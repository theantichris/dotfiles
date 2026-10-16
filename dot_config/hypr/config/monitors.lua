-- Monitor wiki https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Example: output can be found with hyprctl monitors. Edit variables.lua for the monitor outputs instead of here directly
-- hl.monitor({
--     output    = MONITOR1,
--     mode      = "1920x1080@60",
--     position  = "0x0",
--     scale     = "1",
-- })

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "3440x1440@59.97",
    position = "0x0",
    scale    = 1,
    bitdepth = 8,
    vrr      = 0,
})

hl.monitor({
    output   = "eDP-1",
    mode     = "3840x2400@240",
    position = "auto-right",
    scale    = 2,
    vrr      = 0,
})
