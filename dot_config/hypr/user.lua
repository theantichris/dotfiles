if _G.__cyberpunk_user_loaded then return end
if not _G.__cyberpunk_user_scan then _G.__cyberpunk_user_loaded = true end

local cyberpunk = os.getenv("HOME") .. "/.config/hypr/themes/cyberpunk"
local augSock   = os.getenv("XDG_RUNTIME_DIR") .. "/astal/cyberpunk.sock"

local once = function(cmd)
    hl.on("hyprland.start", function() hl.exec_cmd(cmd) end)
end

local function sock(msg)
    return hl.dsp.exec_cmd('echo "' .. msg .. '" | socat - UNIX-CONNECT:' .. augSock)
end

local function app(path)
    return hl.dsp.exec_cmd(cyberpunk .. "/" .. path)
end

local function rawbind(combo, run, opts)
    if opts then hl.bind(combo, run, opts) else hl.bind(combo, run) end
end

CD = CD or {}
CD.sock = sock
CD.app  = app

once("pgrep hypridle >/dev/null 2>&1 || hypridle")
once("copyq --start-server")
once("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
once("nm-applet --indicator")
once("blueman-applet")
once(cyberpunk .. "/scripts/overkill prewarm")

hl.define_submap("kill", function()
    hl.bind("mouse:272", app("scripts/overkill kill"))
    hl.bind("escape",    app("scripts/overkill exit"))
end)

hl.bind("SUPER + E", hl.dsp.exec_cmd("dolphin"))

-- Use Caps Lock as an additional Super key.
hl.config({ input = { kb_options = "caps:super" } })

-- Preserve native resolution for XWayland applications and games.
hl.config({ xwayland = { force_zero_scaling = true } })

-- Christopher's docked layout: Corsair left, tranchion panel right.
hl.monitor({
    output = "desc:CORSAIR MEMORY Inc. 34WQHD240-C A958A4231050",
    mode = "3440x1440@240",
    position = "0x0",
    scale = 1,
    bitdepth = 10,
    vrr = 0,
})
hl.monitor({
    output = "eDP-1",
    mode = "3840x2400@240",
    position = "auto-right",
    scale = 2,
    bitdepth = 10,
    vrr = 0,
})

-- Gather dynamic workspaces on docking or startup; manual moves remain available.
local corsairDescription = "CORSAIR MEMORY Inc. 34WQHD240-C A958A4231050"
local corsairSelector = "desc:" .. corsairDescription
hl.workspace_rule({ workspace = "10", monitor = "eDP-1" })

local function gather_workspaces()
    local external = hl.get_monitor(corsairSelector)
    if not external then return end
    local laptop = hl.get_monitor("eDP-1")
    local function target_monitor(workspace)
        return workspace.id == 10 and laptop or external
    end
    local ids = {}
    for _, workspace in ipairs(hl.get_workspaces()) do
        if not workspace.special and (not workspace.monitor or workspace.monitor.id ~= target_monitor(workspace).id) then
            ids[#ids + 1] = workspace.id
        end
    end
    for _, id in ipairs(ids) do
        local workspace = hl.get_workspace(id)
        local target = workspace and target_monitor(workspace)
        if workspace and target and (not workspace.monitor or workspace.monitor.id ~= target.id) then
            hl.dispatch(hl.dsp.workspace.move({ workspace = workspace, monitor = target }))
        end
    end
end
hl.on("hyprland.start", gather_workspaces)
hl.on("monitor.added", function(monitor)
    if monitor and monitor.description == corsairDescription then gather_workspaces() end
end)
CD.gatherWorkspaces = gather_workspaces

-- Closing the lid while docked keeps the Corsair active. Undocked lid behavior
-- remains with systemd-logind. Restore the panel on opening or undocking.
local function enable_laptop_display()
    hl.monitor({
        output = "eDP-1",
        disabled = false,
        mode = "3840x2400@240",
        position = "auto-right",
        scale = 2,
        bitdepth = 10,
        vrr = 0,
    })
end

hl.bind("switch:on:Lid Switch", function()
    if hl.get_monitor(corsairSelector) then
        hl.monitor({ output = "eDP-1", disabled = true })
    end
end, { locked = true, description = "Clamshell: disable laptop screen when docked" })

hl.bind("switch:off:Lid Switch", enable_laptop_display,
    { locked = true, description = "Restore laptop screen when lid opens" })

hl.on("monitor.removed", function(monitor)
    if monitor and (monitor.description == corsairDescription or monitor.name == "DP-5") then
        enable_laptop_display()
    end
end)

-- Christopher's games use fullscreen and full opacity; Battle.net stays a normal app.
local gamingApps = "^(steam_app.*|gamescope)$"
local launcherTitle = "negative:(?i)^(Battle\\.net|)$"
local launcherInitialTitle = "negative:(?i)^(.*\\\\home\\\\.*|Battle\\.net)$"

for _, gameMatch in ipairs({
    { class = gamingApps, title = launcherTitle, initial_title = launcherInitialTitle },
    { xdg_tag = "^(.*game.*)$", title = launcherTitle, initial_title = launcherInitialTitle },
}) do
    hl.window_rule({
        match            = gameMatch,
        content          = "game",
        opacity          = "1.0 override",
        decorate         = false,
        float            = false,
        fullscreen_state = "2 2",
        -- Keep later maximize requests from replacing fullscreen.
        suppress_event   = "maximize",
        size             = { "monitor_w", "monitor_h" },
        sync_fullscreen  = true,
    })
end

hl.window_rule({ match = { class = "^(steam)$", title = "^(Friends List)$" }, float = true })
hl.window_rule({ match = { class = "^(steam)$", title = "^(Launching\\.{3})$" }, float = true })
hl.window_rule({
    match = { class = "^(steam_app.*)$", initial_title = "^$" },
    center           = true,
    float            = true,
    fullscreen       = false,
    fullscreen_state = 0,
})
