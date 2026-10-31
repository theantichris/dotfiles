--!nonstrict

local displayOff = false

noctalia.idle.watch(1800, function(idle)
    local action = idle and "dpms-off" or "dpms-on"
    if noctalia.runAsync({ "noctalia", "msg", action }) then
        displayOff = idle
    else
        noctalia.log("Could not launch monitor power command: " .. action)
    end
end, { ignoreInhibitors = true })

function onExit()
    if displayOff then
        noctalia.runAsync({ "noctalia", "msg", "dpms-on" })
    end
end
