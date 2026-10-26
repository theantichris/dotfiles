-- Stagger new floating windows across three positions per workspace and monitor.
local slots = {}
return hl.on("window.open", function(window)
    if not window or not window.floating or window.fullscreen ~= 0 or window.pinned then
        return
    end
    local workspace = window.workspace
    local monitor = window.monitor
    if not workspace or workspace.special or not monitor then
        return
    end
    if window.content_type == "game" or window.class == "gamescope"
        or window.class:match("^steam_app") or (window.xdg_tag or ""):find("game") then
        return
    end

    local reserved = monitor.reserved
    local margin = 16
    local left = monitor.position.x + reserved.left + margin
    local top = monitor.position.y + reserved.top + margin
    local right = monitor.position.x + monitor.width / monitor.scale - reserved.right - margin
    local bottom = monitor.position.y + monitor.height / monitor.scale - reserved.bottom - margin
    local key = tostring(monitor.id) .. ":" .. tostring(workspace.id)
    local slot = slots[key] or 0
    local offset = slot * 40
    local x = math.floor((left + right - window.size.x) / 2 - 40 + offset)
    local y = math.floor((top + bottom - window.size.y) / 2 - 40 + offset)
    x = math.max(left, math.min(x, right - window.size.x))
    y = math.max(top, math.min(y, bottom - window.size.y))

    hl.dispatch(hl.dsp.window.move({ window = window, x = x, y = y, relative = false }))
    slots[key] = (slot + 1) % 3
end)
