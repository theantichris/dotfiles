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

hl.bind("switch:on:Lid Switch", function()
    if hl.get_monitor("DP-5") then
        hl.monitor({ output = "eDP-1", disabled = true })
    end
end, { locked = true, description = "Clamshell: disable laptop screen when docked" })

hl.bind("switch:off:Lid Switch", enable_laptop_display,
    { locked = true, description = "Restore laptop screen when lid opens" })

hl.on("monitor.removed", function(monitor)
    if monitor and monitor.name == "DP-5" then
        enable_laptop_display()
    end
end)
