local mainMod = "SUPER"
local noctCall = "noctalia msg "
local launchPrefix = "uwsm app -- " -- if you are not using UWSM, make this empty (e.g. "")

-- 1. Windows

-- Window manipulation
hl.bind(mainMod .. " + Escape",        hl.dsp.exec_cmd("hyprctl kill"),                 { description = "Kill window" })
hl.bind(mainMod .. " + Q",             hl.dsp.window.close(),                          { description = "Close window" })
hl.bind(mainMod .. " + SHIFT + Space", function()
    local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()
    if not workspace then
        return
    end

    local windows = hl.get_windows({ workspace = workspace, mapped = true })
    local action = "unset"
    for _, window in ipairs(windows) do
        if not window.floating then
            action = "set"
            break
        end
    end

    for _, window in ipairs(windows) do
        hl.dispatch(hl.dsp.window.float({ window = window, action = action }))
    end
end, { description = "Toggle floating for all windows on current workspace" })
hl.bind(mainMod .. " + D",             hl.dsp.window.fullscreen({ mode = 1 }),         { description = "Maximize window" })
hl.bind(mainMod .. " + F",             hl.dsp.window.fullscreen(),                     { description = "Toggle fullscreen" })
hl.bind(mainMod .. " + CONTROL + C",   hl.dsp.window.center(),                         { description = "Center floating window" })

-- Change focus
hl.bind(mainMod .. " + H",   hl.dsp.focus({ direction = "left" }),  { description = "Focus left" })
hl.bind(mainMod .. " + L",   hl.dsp.focus({ direction = "right" }), { description = "Focus right" })
hl.bind(mainMod .. " + K",   hl.dsp.focus({ direction = "up" }),    { description = "Focus up" })
hl.bind(mainMod .. " + J",   hl.dsp.focus({ direction = "down" }),  { description = "Focus down" })
hl.bind("ALT + Tab",         hl.dsp.window.cycle_next(),             { description = "Cycle windows" })
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd(noctCall .. "window-switcher"), { description = "Window switcher" })

-- Rearrange tiled windows or nudge floating windows (hold to repeat).
local function moveWindow(direction, x, y)
    return function()
        local window = hl.get_active_window()
        if not window then
            return
        end

        if window.floating then
            hl.dispatch(hl.dsp.window.move({
                window = window, x = x, y = y, relative = true,
            }))
        else
            hl.dispatch(hl.dsp.window.move({ window = window, direction = direction }))
        end
    end
end

hl.bind(mainMod .. " + SHIFT + H", moveWindow("l", -40, 0), { repeating = true, description = "Move window left (tiled: rearrange; floating: 40 px)" })
hl.bind(mainMod .. " + SHIFT + J", moveWindow("d", 0, 40),  { repeating = true, description = "Move window down (tiled: rearrange; floating: 40 px)" })
hl.bind(mainMod .. " + SHIFT + K", moveWindow("u", 0, -40), { repeating = true, description = "Move window up (tiled: rearrange; floating: 40 px)" })
hl.bind(mainMod .. " + SHIFT + L", moveWindow("r", 40, 0),  { repeating = true, description = "Move window right (tiled: rearrange; floating: 40 px)" })

-- Resize active window (hold to repeat)
-- Vertical only redistributes height inside a column, so it is a no-op on the
-- lone master window, and K cannot grow the bottom stack window (nothing below
-- it to take height from).
hl.bind(mainMod .. " + CONTROL + H", hl.dsp.window.resize({ x = -40, y = 0,  relative = true }), { repeating = true, description = "Shrink window width" })
hl.bind(mainMod .. " + CONTROL + L", hl.dsp.window.resize({ x = 40,  y = 0,  relative = true }), { repeating = true, description = "Grow window width" })
hl.bind(mainMod .. " + CONTROL + K", hl.dsp.window.resize({ x = 0,   y = 40,  relative = true }), { repeating = true, description = "Grow window height" })
hl.bind(mainMod .. " + CONTROL + J", hl.dsp.window.resize({ x = 0,   y = -40, relative = true }), { repeating = true, description = "Shrink window height" })

-- Scale floating windows proportionally (hold to repeat).
local function scaleWindow(factor)
    return function()
        local window = hl.get_active_window()
        if not window or not window.floating or window.fullscreen ~= 0 then
            return
        end

        local size = window.size
        if size.x <= 0 or size.y <= 0 then
            return
        end

        hl.dispatch(hl.dsp.window.resize({
            window = window,
            x = math.max(1, math.floor(size.x * factor + 0.5)),
            y = math.max(1, math.floor(size.y * factor + 0.5)),
            relative = false,
        }))
    end
end

hl.bind(mainMod .. " + Minus", scaleWindow(1 / 1.1), { repeating = true, description = "Shrink floating window proportionally" })
hl.bind(mainMod .. " + Equal", scaleWindow(1.1),     { repeating = true, description = "Grow floating window proportionally" })

-- Reset master split to 50/50
hl.bind(mainMod .. " + CONTROL + R", hl.dsp.layout("mfact exact 0.5"), { description = "Reset master split" })

-- Move & Resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { description = "Drag window" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { description = "Resize window" })

-- 2. Applications

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(launchPrefix .. TERMINAL),     { description = "Open terminal" })
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(launchPrefix .. FILE_MANAGER), { description = "Open file manager" })
hl.bind(mainMod .. " + T",      hl.dsp.exec_cmd(launchPrefix .. EDITOR),       { description = "Open editor" })
hl.bind(mainMod .. " + C",      hl.dsp.exec_cmd(launchPrefix .. CALCULATOR),   { description = "Open calculator" })
hl.bind("XF86Calculator",       hl.dsp.exec_cmd(launchPrefix .. CALCULATOR),   { description = "Open calculator" })
hl.bind(mainMod .. " + W",      hl.dsp.exec_cmd(launchPrefix .. BROWSER),      { description = "Open browser" })
hl.bind(mainMod .. " + SHIFT + Escape", hl.dsp.exec_cmd(
    launchPrefix .. TERMINAL .. " -e btop",
    { float = true, size = { "monitor_w*0.65", "monitor_h*0.72" }, center = true }
), { description = "System monitor" })

-- 3. Shell

hl.bind(mainMod .. " + Z",      hl.dsp.exec_cmd(noctCall .. "settings-toggle"),                         { description = "Noctalia settings" })
hl.bind(mainMod .. " + X",      hl.dsp.exec_cmd(noctCall .. "panel-toggle control-center"),             { description = "Control center" })
hl.bind(mainMod .. " + Space",  hl.dsp.exec_cmd(noctCall .. "panel-toggle launcher"),                   { description = "App launcher" })
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd(noctCall .. "panel-toggle launcher /emo"),              { description = "Emoji launcher" })
hl.bind(mainMod .. " + slash",  hl.dsp.exec_cmd("noctalia msg panel-toggle kenn/keybind-cheatsheet:cheatsheet"), { description = "Keybind cheatsheet" })
hl.bind(mainMod .. " + CONTROL + Escape", hl.dsp.exec_cmd(noctCall .. "session lock"), { description = "Lock screen" })
hl.bind(mainMod .. " + ALT + C", hl.dsp.exec_cmd(noctCall .. "panel-toggle session"), { description = "Session menu" })

-- 4. Hardware

-- Audio
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(noctCall .. "volume-up"),   { locked = true, repeating = true, description = "Volume up" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(noctCall .. "volume-down"), { locked = true, repeating = true, description = "Volume down" })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(noctCall .. "volume-mute"), { locked = true, description = "Mute audio" })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd(noctCall .. "mic-mute"),    { locked = true, description = "Mute microphone" })

-- Media
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd(noctCall .. "media toggle"),   { locked = true, description = "Play or pause media" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(noctCall .. "media toggle"),   { locked = true, description = "Play or pause media" })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd(noctCall .. "media next"),     { locked = true, description = "Next media track" })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd(noctCall .. "media previous"), { locked = true, description = "Previous media track" })

-- Brightness
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(noctCall .. "brightness-up"),   { locked = true, repeating = true, description = "Brightness up" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(noctCall .. "brightness-down"), { locked = true, repeating = true, description = "Brightness down" })

-- 5. Utilities

-- Screen Capture
hl.bind(mainMod .. " + P",     hl.dsp.exec_cmd("hyprpicker -a -n"),                  { description = "Color picker" })
hl.bind("Print",               hl.dsp.exec_cmd(noctCall .. "screenshot-region"),     { description = "Screenshot region" })
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd(noctCall .. "screenshot-fullscreen"), { description = "Screenshot fullscreen" })

-- Theming and Wallpaper
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(noctCall .. "panel-toggle wallpaper"), { description = "Wallpaper picker" })

-- Clipboard
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(noctCall .. "panel-toggle clipboard"), { description = "Clipboard history" })

-- Notifications
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(noctCall .. "panel-toggle control-center notifications"), { description = "Notifications" })

-- 6. Workspaces and monitors

-- Number keys select workspaces; Shift moves the active window and follows.
for i = 1, NUM_WPM do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }),                        { description = "Switch to workspace " .. i })
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = true }),  { description = "Move window to workspace " .. i .. " and follow" })
end

-- Move the entire current workspace (all its windows) using the physical layout:
-- external display on the left, laptop panel on the right.
-- Match the external display by description so HDMI and USB-C/DP both work.
hl.bind(mainMod .. " + ALT + H", hl.dsp.workspace.move({ monitor = "desc:CORSAIR MEMORY Inc. 34WQHD240-C A958A4231050" }), { description = "Move workspace to external monitor (left)" })
hl.bind(mainMod .. " + ALT + L", hl.dsp.workspace.move({ monitor = "eDP-1" }), { description = "Move workspace to laptop monitor (right)" })

-- 7. Scratchpads

-- Dedicated scratchpad terminal
local scratchpadWorkspace = "terminal"
local scratchpadClass = "kitty-scratchpad"
hl.bind(mainMod .. " + grave", function()
    local scratchpads = hl.get_windows({ class = scratchpadClass })
    if #scratchpads == 0 then
        hl.exec_cmd(launchPrefix .. TERMINAL .. " --class " .. scratchpadClass)
    end
    hl.dispatch(hl.dsp.workspace.toggle_special(scratchpadWorkspace))
end, { description = "Scratchpad terminal" })

-- General special workspace (scratchpad)
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special" }), { description = "Send window to scratchpad" })
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special(),               { description = "Toggle scratchpad" })
