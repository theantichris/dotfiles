-- Run from the checkout: lua tests/fan.lua
local windows, active, workspace, monitor, special, currentSubmap, events, bindings
local focusHistory
local function emit(name, ...)
    for _, callback in ipairs(events[name] or {}) do callback(...) end
end
local function raise(window)
    for i, w in ipairs(windows) do
        if w == window then table.remove(windows, i); break end
    end
    windows[#windows + 1] = window
end
hl = {
    dsp = { window = {} }, notification = { create = function() end },
    get_active_workspace = function() return workspace end,
    get_active_monitor = function() return monitor end,
    get_active_special_workspace = function() return special end,
    get_active_window = function() return active end,
    get_current_submap = function() return currentSubmap end,
    get_windows = function(filter)
        local result = {}
        for _, w in ipairs(windows) do
            if w.mapped and w.workspace == filter.workspace and w.monitor == filter.monitor then
                result[#result + 1] = w
            end
        end
        return result
    end,
    dispatch = function(callback) callback() end,
    define_submap = function(_, callback) callback() end,
    bind = function(key, callback)
        bindings[key] = callback
        return { remove = function() end }
    end,
    on = function(event, callback)
        events[event] = events[event] or {}
        table.insert(events[event], callback)
        return { remove = function() end }
    end,
}
hl.dsp.submap = function(name) return function()
    currentSubmap = name == 'reset' and '' or name
    emit('keybinds.submap', currentSubmap)
end end
hl.dsp.focus = function(options) return function()
    assert(options.window.mapped, 'attempt to focus a closed window')
    active = options.window
    for i, window in ipairs(focusHistory) do
        if window == active then table.remove(focusHistory, i); break end
    end
    table.insert(focusHistory, 1, active)
    raise(active) -- models the existing focus.lua callback
    emit('window.active', active)
end end
hl.dsp.window.move = function(options) return function()
    assert(options.window.mapped and options.window.fullscreen == 0)
    options.window.at = { x = options.x, y = options.y }
end end
hl.dsp.window.alter_zorder = function(options) return function() raise(options.window) end end
local function setup(count, scaled)
    events, bindings, windows, currentSubmap, special = {}, {}, {}, '', nil
    monitor = {
        width = scaled and 3840 or 3440, height = scaled and 2400 or 1440,
        scale = scaled and 2 or 1, transform = 0,
        reserved = { left = 0, right = 0, top = 35, bottom = 0 },
        position = { x = scaled and 3440 or 0, y = 0 },
    }
    workspace = { id = 1, special = false, has_fullscreen = false }
    local original = {}
    for i = 1, count do
        local w = {
            address = tostring(i), mapped = true, floating = true, accepts_input = true,
            fullscreen = 0, fullscreen_client = 0, class = 'kitty',
            workspace = workspace, monitor = monitor,
            at = { x = monitor.position.x + 100 + i * 80, y = 200 + i * 80 },
            size = { x = 1600, y = 900 },
        }
        windows[i], original[i] = w, { window = w, x = w.at.x, y = w.at.y }
    end
    active = windows[#windows]
    focusHistory = {}
    for i = #windows, 1, -1 do focusHistory[#focusHistory + 1] = windows[i] end
    return dofile('dot_config/hypr/config/fan.lua'), original
end
local function restored(original, skip)
    for _, item in ipairs(original) do
        if item.window ~= skip then
            assert(item.window.at.x == item.x and item.window.at.y == item.y, 'geometry not restored')
            assert(item.window.size.x == 1600 and item.window.size.y == 900, 'size changed')
        end
    end
    assert(currentSubmap == '', 'submap stuck')
end

local function spatiallyValid(original)
    local width, height = monitor.width, monitor.height
    if monitor.transform % 2 == 1 then width, height = height, width end
    local left = monitor.position.x + monitor.reserved.left + 16
    local top = monitor.position.y + monitor.reserved.top + 16
    local right = monitor.position.x + width / monitor.scale - monitor.reserved.right - 16
    local bottom = monitor.position.y + height / monitor.scale - monitor.reserved.bottom - 16
    assert(math.abs(active.at.x + active.size.x / 2 - (left + right) / 2) <= 1, 'selection not centered horizontally')
    assert(math.abs(active.at.y + active.size.y / 2 - (top + bottom) / 2) <= 1, 'selection not centered vertically')
    assert(windows[#windows] == active, 'selection not in front')
    local xs, ys = {}, {}
    for _, item in ipairs(original) do
        local w = item.window
        assert(w.at.x >= left - 1 and w.at.x + w.size.x <= right + 1, 'horizontal boundary crossed')
        assert(w.at.y >= top - 1 and w.at.y + w.size.y <= bottom + 1, 'vertical boundary crossed')
        xs[#xs + 1], xs[#xs + 2] = w.at.x, w.at.x + w.size.x
        ys[#ys + 1], ys[#ys + 2] = w.at.y, w.at.y + w.size.y
    end
    table.sort(xs)
    table.sort(ys)
    -- Partition the rectangles at every edge and attribute each cell to its
    -- topmost window. This detects fully obscured surfaces, including mixed sizes.
    local exposed = {}
    for x = 1, #xs - 1 do
        for y = 1, #ys - 1 do
            local cx, cy = (xs[x] + xs[x + 1]) / 2, (ys[y] + ys[y + 1]) / 2
            for i = #windows, 1, -1 do
                local w = windows[i]
                if cx >= w.at.x and cx < w.at.x + w.size.x and cy >= w.at.y and cy < w.at.y + w.size.y then
                    exposed[w] = (exposed[w] or 0) + (xs[x + 1] - xs[x]) * (ys[y + 1] - ys[y])
                    break
                end
            end
        end
    end
    for _, item in ipairs(original) do assert((exposed[item.window] or 0) > 0, 'surface completely obscured') end
end

for _, scaled in ipairs({ false, true }) do
    for count = 2, 5 do
        local fan, original = setup(count, scaled)
        fan.start()
        assert(currentSubmap == 'cyberdeck-fan')
        spatiallyValid(original)
        local positions = {}
        for _, item in ipairs(original) do positions[item.window] = { x = item.window.at.x, y = item.window.at.y } end
        for _ = 1, count do
            fan.step(1)
            spatiallyValid(original)
        end
        for _, item in ipairs(original) do
            local at = positions[item.window]
            assert(item.window.at.x == at.x and item.window.at.y == at.y, 'full navigation cycle changed composition')
        end
        local lastX, lastY
        for _, item in ipairs(original) do
            local w = item.window
            assert(w.at.x >= monitor.position.x and w.at.x + w.size.x <= monitor.position.x + monitor.width / monitor.scale)
            assert(w.at.y >= 35 and w.at.y + w.size.y <= monitor.height / monitor.scale)
            assert(w.at.x ~= lastX or w.at.y ~= lastY, 'spread collapsed')
            lastX, lastY = w.at.x, w.at.y
        end
        local initialFocus = active
        bindings.L()
        assert(active ~= initialFocus)
        fan.cancel()
        restored(original)
        assert(active == initialFocus)
        for i, item in ipairs(original) do assert(windows[i] == item.window, 'stack not restored') end
        fan.start()
        fan.step(-1)
        local selected = active
        fan.confirm()
        restored(original)
        assert(active == selected and windows[#windows] == selected)
        assert(focusHistory[2] == initialFocus, 'pre-Fan window is not the previous focus')
    end
end
-- Negative monitor origins, rotation, asymmetric reservations and varied sizes.
for _, rotated in ipairs({ false, true }) do
    local fan, original = setup(5)
    monitor.position = { x = -3440, y = -120 }
    monitor.reserved = { left = 37, top = 53, right = 71, bottom = 23 }
    if rotated then monitor.width, monitor.height, monitor.transform = 1440, 3440, 1 end
    original[1].window.size = { x = 700, y = 420 }
    original[2].window.size = { x = 1200, y = 700 }
    original[3].window.size = { x = 1400, y = 850 }
    fan.start()
    for _ = 1, 5 do spatiallyValid(original); fan.step(1) end
    fan.cancel()
    for _, item in ipairs(original) do
        assert(item.window.at.x == item.x and item.window.at.y == item.y, 'mixed geometry not restored')
    end
end
local fan, original = setup(4)
fan.start()
fan.step(1)
local closing = active
closing.mapped = false
emit('window.close', closing)
restored(original, closing)
assert(active ~= closing)
fan, original = setup(3)
fan.start()
local new = { mapped = true, workspace = workspace, monitor = monitor }
emit('window.open', new)
restored(original)
fan, original = setup(3)
fan.start()
workspace = { id = 2 }
emit('workspace.active', workspace)
restored(original)
fan, original = setup(3)
fan.start()
local moved = original[1].window
moved.workspace = { id = 2 }
local x, y = moved.at.x, moved.at.y
emit('window.move_to_workspace', moved)
restored({ original[2], original[3] })
assert(moved.at.x == x and moved.at.y == y, 'moved window pulled back')
fan, original = setup(3)
fan.start()
emit('config.unload')
restored(original)
fan, original = setup(3)
workspace.has_fullscreen = true
fan.start()
restored(original)
workspace.has_fullscreen = false
special = { special = true }
fan.start()
restored(original)
special = nil
original[1].window.size.x = 4000
fan.start()
assert(currentSubmap == '')
-- Filters exclude games, pinned, grouped, hidden and tiled windows.
for _, property in ipairs({ 'pinned', 'group', 'hidden' }) do
    fan, original = setup(2)
    original[1].window[property] = true
    fan.start()
    restored(original)
end
fan, original = setup(2)
original[1].window.floating = false
fan.start()
restored(original)
print('PASS: 2/3/4/5 windows, centered selection, exposed inactive surfaces, cyclic composition, both monitor dimensions, mixed sizes, rotation/origins/reservations, confirm/cancel, geometry/stack/history restoration and lifecycle handling')
