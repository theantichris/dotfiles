hl.config({
  input = {
    accel_profile = "flat",
    follow_mouse = 0,
    numlock_by_default = true,
    kb_options = "caps:super",
  },
  cursor = {
    inactive_timeout = 1,
    hide_on_key_press = true,
  },
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down", action = "close" })
hl.gesture({ fingers = 3, direction = "up", action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "left", action = "float" })
