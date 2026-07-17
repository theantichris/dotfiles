local mainMod = "SUPER"
local noctCall = "qs -c noctalia-shell ipc call "
local launchPrefix = "uwsm app -- " -- if you are not using UWSM, make this empty (e.g. "")

---------------------------
---- WINDOW MANAGEMENT ----
---------------------------

hl.bind(mainMod .. " + Escape",      hl.dsp.exec_cmd("hyprctl kill"))
hl.bind(mainMod .. " + Q",           hl.dsp.window.close())
hl.bind(mainMod .. " + ALT + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D",           hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(mainMod .. " + F",           hl.dsp.window.fullscreen())
--hl.bind(mainMod .. " + J",           hl.dsp.layout("togglesplit"))
--hl.bind(mainMod .. " + L",           hl.dsp.exec_cmd(noctCall .. " lockScreen lock"))
hl.bind(mainMod .. " + ALT + C",     hl.dsp.exec_cmd(noctCall .. " sessionMenu toggle"))

-- Change focus
hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + Tab",           hl.dsp.window.cycle_next())

-- Move active window around current workspace
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + H",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + K",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + J",  hl.dsp.window.move({ direction = "d" }))
hl.bind(mainMod .. " + CONTROL + SHIFT + L", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mainMod .. " + CONTROL + SHIFT + H",  hl.dsp.window.move({ workspace = "r-1" }))

-- Resize active window (hold to repeat)
hl.bind(mainMod .. " + CONTROL + H", hl.dsp.window.resize({ x = -40, y = 0,  relative = true }), { repeating = true })
hl.bind(mainMod .. " + CONTROL + L", hl.dsp.window.resize({ x = 40,  y = 0,  relative = true }), { repeating = true })
hl.bind(mainMod .. " + CONTROL + K", hl.dsp.window.resize({ x = 0,   y = -40, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CONTROL + J", hl.dsp.window.resize({ x = 0,   y = 40,  relative = true }), { repeating = true })

-- Reset master split to 50/50
hl.bind(mainMod .. " + CONTROL + R", hl.dsp.layout("mfact exact 0.5"))

-- Move & Resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

------------------
---- LAUNCHER ----
------------------

hl.bind(mainMod .. " + Return",     hl.dsp.exec_cmd(launchPrefix .. TERMINAL))
hl.bind(mainMod .. " + E",          hl.dsp.exec_cmd(launchPrefix .. FILE_MANAGER))
hl.bind(mainMod .. " + T",          hl.dsp.exec_cmd(launchPrefix .. EDITOR))
hl.bind(mainMod .. " + C",          hl.dsp.exec_cmd(launchPrefix .. CALCULATOR))
hl.bind(mainMod .. " + W",          hl.dsp.exec_cmd(launchPrefix .. BROWSER))
hl.bind("CONTROL + SHIFT + Escape", hl.dsp.exec_cmd(launchPrefix .. TERMINAL .. " -e btop"))
hl.bind(mainMod .. " + Z",          hl.dsp.exec_cmd(noctCall .. "settings toggle"))
hl.bind(mainMod .. " + X",          hl.dsp.exec_cmd(noctCall .. "controlCenter toggle"))
hl.bind(mainMod .. " + Space",      hl.dsp.exec_cmd(noctCall .. "launcher toggle"))
hl.bind(mainMod .. " + period",     hl.dsp.exec_cmd(noctCall .. "launcher emoji"))

---------------------------
---- HARDWARE CONTROLS ----
---------------------------

-- Audio
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(noctCall .. "volume increase"),   { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(noctCall .. "volume decrease"),   { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd(noctCall .. "volume muteOutput"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd(noctCall .. "volume muteInput"),  { locked = true, repeating = true })

-- Toggle default audio output+input between speakers/Brio webcam and earbuds
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd(
  "sh -c '" ..
  "cur=$(pactl get-default-sink); " ..
  "if [ \"$cur\" = \"alsa_output.usb-SteelSeries_Arctis_GameBuds_X-00.analog-stereo\" ]; then " ..
    "newsink=alsa_output.pci-0000_00_1f.3.analog-stereo; " ..
    "newsource=alsa_input.usb-046d_Brio_101_2433AP05NRY8-02.mono-fallback; " ..
    "label=Speakers+Brio; " ..
  "else " ..
    "newsink=alsa_output.usb-SteelSeries_Arctis_GameBuds_X-00.analog-stereo; " ..
    "newsource=alsa_input.usb-SteelSeries_Arctis_GameBuds_X-00.mono-fallback; " ..
    "label=Earbuds; " ..
  "fi; " ..
  "pactl set-default-sink \"$newsink\"; " ..
  "pactl set-default-source \"$newsource\"; " ..
  "pactl list short sink-inputs | cut -f1 | xargs -r -I{} pactl move-sink-input {} \"$newsink\"; " ..
  "pactl list short source-outputs | cut -f1 | xargs -r -I{} pactl move-source-output {} \"$newsource\"; " ..
  "notify-send \"Audio Device\" \"Switched to $label\"" ..
  "'"
))

-- Media
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd(noctCall .. "media playPause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(noctCall .. "media playPause"), { locked = true })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd(noctCall .. "media next"),      { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd(noctCall .. "media previous"),  { locked = true })

-- Brightness
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(noctCall .. "brightness increase"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(noctCall .. "brightness decrease"), { repeating = true })

-------------------
---- UTILITIES ----
-------------------

-- Screen Capture
hl.bind(mainMod .. " + P",     hl.dsp.exec_cmd(noctCall .. "plugin:screen-toolkit colorPicker"))
hl.bind("Print",               hl.dsp.exec_cmd(noctCall .. "plugin:screen-toolkit annotate"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd(noctCall .. "plugin:screen-toolkit annotateWindow"))
hl.bind(mainMod .. " + R",     hl.dsp.exec_cmd(noctCall .. "plugin:screen-toolkit toggle"))

-- Theming and Wallpaper
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(noctCall .. " wallpaper toggle"))

-- Clipboard
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(noctCall .. "launcher clipboard"))

--------------------
---- WORKSPACES ----
--------------------

for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = true }))
    hl.bind(mainMod .. " + ALT + " .. key,   hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind(mainMod .. " + CONTROL + Right",       hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + CONTROL + Left",        hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + CONTROL + Down",        hl.dsp.focus({ workspace = "empty" }))
hl.bind(mainMod .. " + CONTROL + ALT + Right", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mainMod .. " + CONTROL + ALT + Left",  hl.dsp.window.move({ workspace = "r-1" }))

-- Scroll through existing workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special" }))
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special())

-----------------------
---- NOTIFICATIONS ----
-----------------------

hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(noctCall .. "notifications toggleHistory"))
