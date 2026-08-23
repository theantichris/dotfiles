-- Auto-start config
-- if you dont use UWSM add your auto start programs here, otherwise use XDG autostart https://wiki.archlinux.org/title/XDG_Autostart

hl.on("hyprland.start", function ()
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    -- Noctalia runs as a systemd user unit (noctalia.service) so journald keeps its logs.
    hl.exec_cmd("xhost +SI:localuser:root")
    hl.exec_cmd("seafile-applet")
end)
