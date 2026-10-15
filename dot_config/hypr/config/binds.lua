local mainMod = "SUPER"
local noctCall = "noctalia msg "
local launchPrefix = "uwsm app -- " -- if you are not using UWSM, make this empty (e.g. "")

---------------------------
---- WINDOW MANAGEMENT ----
---------------------------

-- Window manipulation
hl.bind(mainMod .. " + Escape",        hl.dsp.exec_cmd("hyprctl kill"),                 { description = "Kill window" })
hl.bind(mainMod .. " + Q",             hl.dsp.window.close(),                          { description = "Close window" })
hl.bind(mainMod .. " + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }),    { description = "Toggle floating" })
hl.bind(mainMod .. " + D",             hl.dsp.window.fullscreen({ mode = 1 }),         { description = "Maximize window" })
hl.bind(mainMod .. " + F",             hl.dsp.window.fullscreen(),                     { description = "Toggle fullscreen" })
-- J and L are reserved for vim-style focus below
--hl.bind(mainMod .. " + J",           hl.dsp.layout("togglesplit"))

-- Change focus
hl.bind(mainMod .. " + H",   hl.dsp.focus({ direction = "left" }),  { description = "Focus left" })
hl.bind(mainMod .. " + L",   hl.dsp.focus({ direction = "right" }), { description = "Focus right" })
hl.bind(mainMod .. " + K",   hl.dsp.focus({ direction = "up" }),    { description = "Focus up" })
hl.bind(mainMod .. " + J",   hl.dsp.focus({ direction = "down" }),  { description = "Focus down" })
hl.bind("ALT + Tab",         hl.dsp.window.cycle_next(),             { description = "Cycle windows" })
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd(noctCall .. "window-switcher"), { description = "Window switcher" })

-- Move active window around workspaces & monitors
hl.bind(mainMod .. " + SHIFT + K",                    hl.dsp.window.move({ direction = "u" }),           { description = "Move window up" })
hl.bind(mainMod .. " + SHIFT + L",                    hl.dsp.window.move({ direction = "r" }),           { description = "Move window right" })
hl.bind(mainMod .. " + SHIFT + H",                    hl.dsp.window.move({ direction = "l" }),           { description = "Move window left" })
hl.bind(mainMod .. " + SHIFT + J",                    hl.dsp.window.move({ direction = "d" }),           { description = "Move window down" })
hl.bind(mainMod .. " + CONTROL + SHIFT + L",          hl.dsp.window.move({ workspace = "r+1" }),        { description = "Move window to next workspace" })
hl.bind(mainMod .. " + CONTROL + SHIFT + H",          hl.dsp.window.move({ workspace = "r-1" }),        { description = "Move window to previous workspace" })
hl.bind(mainMod .. " + CONTROL + ALT + Right",        hl.dsp.window.move({ workspace = "r+1" }),        { description = "Move window to next workspace" })
hl.bind(mainMod .. " + CONTROL + ALT + Left",         hl.dsp.window.move({ workspace = "r-1" }),        { description = "Move window to previous workspace" })
hl.bind(mainMod .. " + CONTROL + SHIFT + mouse_up",   hl.dsp.window.move({ workspace = "r-1" }),        { description = "Move window to previous workspace" })
hl.bind(mainMod .. " + CONTROL + SHIFT + mouse_down", hl.dsp.window.move({ workspace = "r+1" }),        { description = "Move window to next workspace" })
-- Monitor targets: unused on this single-monitor setup, and they would shadow
-- SUPER + SHIFT + number, which moves a window to workspace N (see WORKSPACES).
-- hl.bind(mainMod .. " + SHIFT + 1",          hl.dsp.window.move({ monitor = MONITOR1 }))
-- hl.bind(mainMod .. " + SHIFT + 2",          hl.dsp.window.move({ monitor = MONITOR2 }))
-- hl.bind(mainMod .. " + SHIFT + 3",          hl.dsp.window.move({ monitor = MONITOR3 }))
-- hl.bind(mainMod .. " + SHIFT + mouse_up",   hl.dsp.window.move({ monitor = "-1" }))
-- hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.window.move({ monitor = "+1" }))

-- Resize active window (hold to repeat)
-- Vertical only redistributes height inside a column, so it is a no-op on the
-- lone master window, and K cannot grow the bottom stack window (nothing below
-- it to take height from).
hl.bind(mainMod .. " + CONTROL + H", hl.dsp.window.resize({ x = -40, y = 0,  relative = true }), { repeating = true, description = "Shrink window width" })
hl.bind(mainMod .. " + CONTROL + L", hl.dsp.window.resize({ x = 40,  y = 0,  relative = true }), { repeating = true, description = "Grow window width" })
hl.bind(mainMod .. " + CONTROL + K", hl.dsp.window.resize({ x = 0,   y = 40,  relative = true }), { repeating = true, description = "Grow window height" })
hl.bind(mainMod .. " + CONTROL + J", hl.dsp.window.resize({ x = 0,   y = -40, relative = true }), { repeating = true, description = "Shrink window height" })

-- Reset master split to 50/50
hl.bind(mainMod .. " + CONTROL + R", hl.dsp.layout("mfact exact 0.5"), { description = "Reset master split" })

-- Move & Resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { description = "Drag window" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { description = "Resize window" })

-- Zoom
local function zoomfunction(value)
    local zoomvalue = hl.get_config("cursor:zoom_factor")
    if (zoomvalue + value) > 3.0 then
        hl.config({ cursor = { zoom_factor = 3.0 } })
    elseif (zoomvalue + value) < 1.0 then
        hl.config({ cursor = { zoom_factor = 1.0 } })
    else
        hl.config({ cursor = { zoom_factor = zoomvalue + value } })
    end
end
hl.bind(mainMod .. " + Minus", function() zoomfunction(-0.3) end, { repeating = true, description = "Zoom out" })
hl.bind(mainMod .. " + Plus",  function() zoomfunction(0.3) end,  { repeating = true, description = "Zoom in" })

--# Zoom with keypad
hl.bind(mainMod .. " + code:82", function() zoomfunction(-0.3) end, { repeating = true, description = "Zoom out" })
hl.bind(mainMod .. " + code:86", function() zoomfunction(0.3) end,  { repeating = true, description = "Zoom in" })


------------------
---- LAUNCHER ----
------------------

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
hl.bind(mainMod .. " + Z",      hl.dsp.exec_cmd(noctCall .. "settings-toggle"),                         { description = "Noctalia settings" })
hl.bind(mainMod .. " + X",      hl.dsp.exec_cmd(noctCall .. "panel-toggle control-center"),             { description = "Control center" })
hl.bind(mainMod .. " + Space",  hl.dsp.exec_cmd(noctCall .. "panel-toggle launcher"),                   { description = "App launcher" })
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd(noctCall .. "panel-toggle launcher /emo"),              { description = "Emoji launcher" })
hl.bind(mainMod .. " + slash",  hl.dsp.exec_cmd("noctalia msg panel-toggle kenn/keybind-cheatsheet:cheatsheet"), { description = "Keybind cheatsheet" })
-- Lock lives in the session panel (SUPER + ALT + C, then 1); SUPER + L is focus-right
--hl.bind(mainMod .. " + L",          hl.dsp.exec_cmd(noctCall .. "session lock"))
hl.bind(mainMod .. " + ALT + C", hl.dsp.exec_cmd(noctCall .. "panel-toggle session"), { description = "Session menu" })

---------------------------
---- HARDWARE CONTROLS ----
---------------------------

-- Audio
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(noctCall .. "volume-up"),   { locked = true, repeating = true, description = "Volume up" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(noctCall .. "volume-down"), { locked = true, repeating = true, description = "Volume down" })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(noctCall .. "volume-mute"), { locked = true, description = "Mute audio" })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd(noctCall .. "mic-mute"),    { locked = true, description = "Mute microphone" })

-- Cycle default audio output+input: Speakers+Brio -> GameBuds -> Space 2+Brio
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("~/.config/hypr/scripts/audio-switch.sh"), { description = "Cycle audio device" })

-- Media
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd(noctCall .. "media toggle"),   { locked = true, description = "Play or pause media" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(noctCall .. "media toggle"),   { locked = true, description = "Play or pause media" })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd(noctCall .. "media next"),     { locked = true, description = "Next media track" })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd(noctCall .. "media previous"), { locked = true, description = "Previous media track" })

-- Brightness
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(noctCall .. "brightness-up"),   { locked = true, repeating = true, description = "Brightness up" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(noctCall .. "brightness-down"), { locked = true, repeating = true, description = "Brightness down" })

-------------------
---- UTILITIES ----
-------------------

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

-------------------------------
---- WORKSPACES & MONITORS ----
-------------------------------

-- Workspaces on plain SUPER + number, as before v5. Upstream v5 reassigned these
-- chords to monitor focus and pushed workspaces onto SUPER + ALT + number, capped
-- at NUM_WPM -- both no-ops with one monitor.
for i = 1, NUM_WPM do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }),                        { description = "Switch to workspace " .. i })
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = true }),  { description = "Move window to workspace " .. i .. " and follow" })
    hl.bind(mainMod .. " + ALT + " .. key,   hl.dsp.window.move({ workspace = i, follow = false }), { description = "Move window to workspace " .. i })
end

-- Focus on monitors (re-enable alongside a second display)
-- hl.bind(mainMod .. " + CONTROL + SHIFT + 1", hl.dsp.focus({ monitor = MONITOR1 }))
-- hl.bind(mainMod .. " + CONTROL + SHIFT + 2", hl.dsp.focus({ monitor = MONITOR2 }))
-- hl.bind(mainMod .. " + CONTROL + SHIFT + 3", hl.dsp.focus({ monitor = MONITOR3 }))

-- Move to adjacent workspaces and next empty
hl.bind(mainMod .. " + CONTROL + Right", hl.dsp.focus({ workspace = "r+1" }), { description = "Next workspace" })
hl.bind(mainMod .. " + CONTROL + Left",  hl.dsp.focus({ workspace = "r-1" }), { description = "Previous workspace" })
hl.bind(mainMod .. " + CONTROL + Down",  hl.dsp.focus({ workspace = "empty" }), { description = "Next empty workspace" })

-- Scroll through existing workspaces
hl.bind(mainMod .. " + mouse_down",           hl.dsp.focus({ workspace = "e+1" }), { description = "Next existing workspace" })
hl.bind(mainMod .. " + mouse_up",             hl.dsp.focus({ workspace = "e-1" }), { description = "Previous existing workspace" })
hl.bind(mainMod .. " + CONTROL + mouse_up",   hl.dsp.focus({ workspace = "e-1" }), { description = "Previous existing workspace" })
hl.bind(mainMod .. " + CONTROL + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Next existing workspace" })

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
