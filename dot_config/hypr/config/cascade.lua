-- Stagger new floating windows across three positions per workspace and monitor.
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

local function position(window, width, height, slot)
    local monitor = window.monitor
    local reserved = monitor.reserved
    local margin = 16
    local left = monitor.position.x + reserved.left + margin
    local top = monitor.position.y + reserved.top + margin
    local right = monitor.position.x + monitor.width / monitor.scale - reserved.right - margin
    local bottom = monitor.position.y + monitor.height / monitor.scale - reserved.bottom - margin
    local offset = slot * 80
    local x = math.floor((left + right - width) / 2 - 40 + offset)
    local y = math.floor((top + bottom - height) / 2 - 40 + offset)
    x = math.max(left, math.min(x, right - width))
    y = math.max(top, math.min(y, bottom - height))

    return x, y
end

local function vacantSlot(window)
    local occupied = { 0, 0, 0 }
    for _, other in ipairs(hl.get_windows({ workspace = window.workspace, monitor = window.monitor, mapped = true })) do
        if other ~= window and eligible(other) and other.floating and not other.hidden
            and other.fullscreen == 0 then
            -- Compare each surface against slots calculated for its own size.
            -- Moving a window away from the cascade frees its old position.
            for slot = 0, 2 do
                local x, y = position(other, other.size.x, other.size.y, slot)
                if math.abs(other.at.x - x) <= 8 and math.abs(other.at.y - y) <= 8 then
                    occupied[slot + 1] = occupied[slot + 1] + 1
                end
            end
        end
    end
    local best = 1
    for i = 2, 3 do
        if occupied[i] < occupied[best] then
            best = i
        end
    end
    return best - 1
end

local function place(window, width, height, slot)
    local x, y = position(window, width, height, slot or vacantSlot(window))
    hl.dispatch(hl.dsp.window.move({ window = window, x = x, y = y, relative = false }))
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
    local slots = {}
    for _, window in ipairs(windows) do
        hl.dispatch(hl.dsp.window.fullscreen_state({ window = window, action = "set", internal = 0, client = 0 }))
        hl.dispatch(hl.dsp.window.float({ window = window, action = "enable" }))
        hl.dispatch(hl.dsp.window.resize({ window = window, x = 1600, y = 900, relative = false }))
        local key = slotKey(window)
        local slot = slots[key] or 0
        place(window, 1600, 900, slot)
        slots[key] = (slot + 1) % 3
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
