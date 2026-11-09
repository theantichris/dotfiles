-- Temporary, move-only presentation of this monitor's floating surfaces.
local fan = { subscriptions = {}, bindings = {} }
local session
local submap = "cyberdeck-fan"

local function eligible(window)
    return window and window.mapped and window.floating and not window.hidden
        and window.accepts_input and not window.pinned and not window.group
        and window.fullscreen == 0 and window.fullscreen_client == 0
        and window.content_type ~= "game" and window.class ~= "gamescope"
        and (not (window.class or ""):match("^steam_app") or window.initial_title == "Battle.net")
        and not (window.xdg_tag or ""):find("game")
end

local function belongs(window, saved)
    return window and window ~= saved.closed and window.mapped and window.workspace == saved.workspace
        and window.monitor == saved.monitor
end

local function move(window, x, y)
    hl.dispatch(hl.dsp.window.move({ window = window, x = x, y = y, relative = false }))
end

-- Clear state before dispatching: focus/submap events can call back synchronously.
local function finish(confirm, restoreFocus)
    local saved = session
    if not saved then
        return
    end
    session = nil
    if hl.get_current_submap() == submap then
        hl.dispatch(hl.dsp.submap("reset"))
    end
    for _, item in ipairs(saved.items) do
        if belongs(item.window, saved) and eligible(item.window) then
            move(item.window, item.x, item.y)
        end
    end
    local target = confirm and saved.selected or saved.focus
    if restoreFocus and belongs(target, saved) and not target.hidden then
        -- Make the pre-Fan surface the previous focus, rather than the last
        -- surface previewed while browsing. Both dispatches run in this callback.
        if confirm and saved.focus ~= target and belongs(saved.focus, saved)
            and eligible(saved.focus) then
            hl.dispatch(hl.dsp.focus({ window = saved.focus }))
        end
        hl.dispatch(hl.dsp.focus({ window = target }))
    end
    -- get_windows is bottom-to-top in 0.57.1 (WindowState::windows).
    -- Restore local stacking after focus.lua's bring_to_top callback.
    for _, window in ipairs(saved.stack) do
        if belongs(window, saved) and eligible(window) then
            hl.dispatch(hl.dsp.window.alter_zorder({ window = window, mode = "top" }))
        end
    end
    if confirm and restoreFocus and belongs(target, saved) and eligible(target) then
        hl.dispatch(hl.dsp.window.alter_zorder({ window = target, mode = "top" }))
    elseif not restoreFocus then
        local active = hl.get_active_window()
        if belongs(active, saved) and eligible(active) then
            hl.dispatch(hl.dsp.window.alter_zorder({ window = active, mode = "top" }))
        end
    end
end

function fan.cancel()
    finish(false, true)
end

function fan.confirm()
    finish(true, true)
end

local function arrange()
    local saved = session
    if not saved then return end
    local selectedIndex = 1
    for i, item in ipairs(saved.items) do
        if item.window == saved.selected then selectedIndex = i; break end
    end
    local count, placements = #saved.items, {}
    local area = saved.area
    for i, item in ipairs(saved.items) do
        -- Treat the stable spatial order as a ring: next comes from the right,
        -- previous from the left, including across the navigation wrap.
        local offset = (i - selectedIndex) % count
        if offset > math.floor(count / 2) then offset = offset - count end
        local depth = math.abs(offset)
        local layer = depth + (offset < 0 and 0.5 or 0)
        local size = item.window.size
        placements[#placements + 1] = {
            window = item.window, depth = layer,
            x = math.floor(area.left + (area.width - size.x) / 2 + offset * area.pitch),
            y = math.floor(area.top + (area.height - (depth == 0 and size.y or area.maxHeight)) / 2 - layer * area.lift),
        }
    end
    -- Outer surfaces behind inner surfaces, with attention always in front.
    table.sort(placements, function(a, b)
        return a.depth > b.depth
    end)
    for _, placement in ipairs(placements) do
        move(placement.window, placement.x, placement.y)
        hl.dispatch(hl.dsp.window.alter_zorder({ window = placement.window, mode = "top" }))
    end
end

function fan.step(delta)
    if not session then
        return
    end
    local index = 1
    for i, item in ipairs(session.items) do
        if item.window == session.selected then
            index = i
            break
        end
    end
    index = (index - 1 + delta) % #session.items + 1
    session.selected = session.items[index].window
    arrange()
    hl.dispatch(hl.dsp.focus({ window = session.selected }))
end

function fan.start()
    if session then
        fan.cancel()
        return
    end
    local workspace = hl.get_active_workspace()
    local monitor = hl.get_active_monitor()
    if not workspace or not monitor or workspace.special or workspace.has_fullscreen
        or hl.get_active_special_workspace() or hl.get_current_submap() ~= "" then
        return
    end

    local items, stack = {}, {}
    local maxWidth, maxHeight = 0, 0
    for _, window in ipairs(hl.get_windows({ workspace = workspace, monitor = monitor, mapped = true })) do
        if eligible(window) then
            local at, size = window.at, window.size
            items[#items + 1] = { window = window, x = at.x, y = at.y }
            stack[#stack + 1] = window
            maxWidth = math.max(maxWidth, size.x)
            maxHeight = math.max(maxHeight, size.y)
        end
    end
    if #items < 2 then
        return
    end

    -- Physical dimensions need swapping before conversion to logical coordinates.
    local width, height = monitor.width, monitor.height
    if monitor.transform % 2 == 1 then
        width, height = height, width
    end
    local reserved, margin = monitor.reserved, 16
    local left = monitor.position.x + reserved.left + margin
    local top = monitor.position.y + reserved.top + margin
    local usableWidth = width / monitor.scale - reserved.left - reserved.right - margin * 2
    local usableHeight = height / monitor.scale - reserved.top - reserved.bottom - margin * 2
    local spanX = usableWidth - maxWidth
    local spanY = usableHeight - maxHeight
    local maxDepth = math.floor(#items / 2)
    local pitch = spanX / (2 * maxDepth)
    -- Do not resize clients or spill onto another monitor to manufacture space.
    if spanX < 0 or spanY < 0 or pitch < 48 then
        hl.notification.create({ text = "Fan: insufficient room for a move-only spread", timeout = 2500 })
        return
    end
    table.sort(items, function(a, b)
        if a.x ~= b.x then return a.x < b.x end
        if a.y ~= b.y then return a.y < b.y end
        return tostring(a.window.address) < tostring(b.window.address)
    end)
    session = {
        workspace = workspace, monitor = monitor, items = items, stack = stack,
        focus = hl.get_active_window(), selected = hl.get_active_window(),
        area = {
            left = left, top = top, width = usableWidth, height = usableHeight,
            pitch = pitch, maxHeight = maxHeight,
            lift = math.min(usableHeight * 0.045, spanY / (2 * (maxDepth + 0.5))),
        },
    }
    local found = false
    for _, item in ipairs(items) do
        found = found or item.window == session.selected
    end
    if not found then session.selected = items[1].window end
    hl.dispatch(hl.dsp.submap(submap))
    arrange()
    hl.dispatch(hl.dsp.focus({ window = session.selected }))
end

local function bind(key, callback, options)
    options = options or {}
    fan.bindings[#fan.bindings + 1] = hl.bind(key, callback, options)
end

-- 7. Fan

bind("SUPER + SHIFT + Tab", fan.start, { description = "Fan floating surfaces" })
hl.define_submap(submap, function()
    for _, key in ipairs({ "L", "J" }) do
        bind(key, function() fan.step(1) end, { description = "Fan: next surface" })
    end
    for _, key in ipairs({ "H", "K" }) do
        bind(key, function() fan.step(-1) end, { description = "Fan: previous surface" })
    end
    bind("Return", fan.confirm, { description = "Fan: confirm" })
    bind("Escape", fan.cancel, { ignore_mods = true, description = "Fan: cancel" })
    -- Keep the lock shortcut available without leaving a spread behind.
    bind("SUPER + CONTROL + Escape", function()
        fan.cancel()
        hl.exec_cmd("noctalia msg session lock")
    end, { description = "Fan: cancel and lock" })
end)

local function on(event, callback)
    fan.subscriptions[#fan.subscriptions + 1] = hl.on(event, callback)
end

-- Cancel on lifecycle/context changes rather than racing a new cascade or
-- dragging windows back across a workspace/monitor boundary.
on("window.open", function(window)
    if session and belongs(window, session) then finish(false, false) end
end)
on("window.close", function(window)
    if not session then return end
    for _, item in ipairs(session.items) do
        if item.window == window then
            session.closed = window
            finish(false, true)
            return
        end
    end
end)
on("window.active", function(window)
    if not session then return end
    for _, item in ipairs(session.items) do
        if item.window == window then
            if session.selected ~= window then
                session.selected = window
                arrange()
            end
            return
        end
    end
    finish(false, false)
end)
for _, event in ipairs({
    "workspace.active", "workspace.special_active", "workspace.move_to_monitor",
    "monitor.focused", "monitor.layout_changed", "monitor.removed",
}) do
    on(event, function() finish(false, false) end)
end
for _, event in ipairs({ "window.fullscreen", "window.move_to_workspace", "window.pin", "window.update_state" }) do
    on(event, function(window)
        if not session then return end
        for _, item in ipairs(session.items) do
            if item.window == window then finish(false, false); return end
        end
    end)
end
on("keybinds.submap", function(name)
    if name ~= submap then finish(false, true) end
end)
on("config.unload", fan.cancel)

-- Also permits a temporary live test to remove its own bindings/subscriptions.
function fan.dispose()
    fan.cancel()
    for _, binding in ipairs(fan.bindings) do binding:remove() end
    for _, subscription in ipairs(fan.subscriptions) do subscription:remove() end
end

return fan
