-- Stagger new floating windows across three positions per workspace and monitor.
local slots = {}
local cascade = {}

local function eligible(window)
    return window and window.workspace and not window.workspace.special
        and window.monitor and not window.pinned
        and window.content_type ~= "game" and window.class ~= "gamescope"
        and not (window.class or ""):match("^steam_app")
        and not (window.xdg_tag or ""):find("game")
end

local function slotKey(window)
    return tostring(window.monitor.id) .. ":" .. tostring(window.workspace.id)
end

local function place(window, width, height)
    local monitor = window.monitor
    local reserved = monitor.reserved
    local margin = 16
    local left = monitor.position.x + reserved.left + margin
    local top = monitor.position.y + reserved.top + margin
    local right = monitor.position.x + monitor.width / monitor.scale - reserved.right - margin
    local bottom = monitor.position.y + monitor.height / monitor.scale - reserved.bottom - margin
    local key = slotKey(window)
    local slot = slots[key] or 0
    local offset = slot * 40
    local x = math.floor((left + right - width) / 2 - 40 + offset)
    local y = math.floor((top + bottom - height) / 2 - 40 + offset)
    x = math.max(left, math.min(x, right - width))
    y = math.max(top, math.min(y, bottom - height))

    hl.dispatch(hl.dsp.window.move({ window = window, x = x, y = y, relative = false }))
    slots[key] = (slot + 1) % 3
end

function cascade.resetWorkspace()
    -- A visible scratchpad should never reset the workspace behind it.
    local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()
    if not workspace or workspace.special then
        return
    end

    local windows = {}
    for _, window in ipairs(hl.get_windows({ workspace = workspace, mapped = true })) do
        if eligible(window) then
            table.insert(windows, window)
        end
    end
    if #windows == 0 then
        return
    end
    table.sort(windows, function(a, b)
        return tostring(a.address) < tostring(b.address)
    end)

    local active = hl.get_active_window()
    for _, window in ipairs(windows) do
        slots[slotKey(window)] = 0
    end
    for _, window in ipairs(windows) do
        hl.dispatch(hl.dsp.window.fullscreen_state({ window = window, action = "set", internal = 0, client = 0 }))
        hl.dispatch(hl.dsp.window.float({ window = window, action = "set" }))
        hl.dispatch(hl.dsp.window.resize({ window = window, x = 1600, y = 900, relative = false }))
        place(window, 1600, 900)
    end
    if active then
        hl.dispatch(hl.dsp.focus({ window = active }))
    end
end

-- Retain the subscription alongside the reset function for the module's lifetime.
cascade.subscription = hl.on("window.open", function(window)
    if not eligible(window) or not window.floating or window.fullscreen ~= 0 then
        return
    end
    place(window, window.size.x, window.size.y)
end)

return cascade
