-- Clamshell behavior for the Legion and Corsair USB-C DisplayPort connection.
-- systemd-logind retains its default lid-close suspend behavior when undocked.

local function enable_laptop_display()
    hl.monitor({
        output   = "eDP-1",
        disabled = false,
        mode     = "3840x2400@240",
        position = "auto-right",
        scale    = 2,
        bitdepth = 10,
        vrr      = 0,
    })
end

-- Closing the lid with the Corsair connected leaves the external display active.
-- Without DP-5, let systemd-logind suspend normally.
hl.bind("switch:on:Lid Switch", function()
    if hl.get_monitor("DP-5") then
        hl.monitor({ output = "eDP-1", disabled = true })
    end
end, { locked = true, description = "Clamshell: disable laptop screen when docked" })

-- Reopen the lid to restore the laptop panel and dual-display arrangement.
hl.bind("switch:off:Lid Switch", enable_laptop_display,
    { locked = true, description = "Restore laptop screen when lid opens" })

-- If the Corsair is unplugged while clamshell is active, restore the laptop
-- panel so the configuration does not leave both displays disabled.
hl.on("monitor.removed", function(monitor)
    if monitor and monitor.name == "DP-5" then
        enable_laptop_display()
    end
end)
