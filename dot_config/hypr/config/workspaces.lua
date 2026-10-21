-- Workspace rules wiki https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- Workspaces stay dynamic (created on demand, bar shows only occupied ones),
-- matching the pre-v5 behavior here. The CachyOS v5 default shipped a
-- `name:gaming` rule with default=true plus persistent 1-3; the named workspace
-- gets a negative id from Hyprland, so numeric binds cannot reach it.
--
-- To pin workspaces to monitors instead, uncomment and adjust:
-- hl.workspace_rule({ workspace = "1", monitor = MONITOR1, default = true, persistent = true })
-- hl.workspace_rule({ workspace = "2", monitor = MONITOR1, default = true, persistent = true })
-- hl.workspace_rule({ workspace = "3", monitor = MONITOR1, default = true, persistent = true })
--
-- For other layouts such as scrolling, see example below
-- hl.workspace_rule({ workspace = "1", monitor = MONITOR1, default = true, persistent = true, layout = scrolling })

-- Toggle only the current workspace between the two tiling layouts. Master
-- remains the global default for new workspaces.
hl.bind("SUPER + SHIFT + M", function()
    local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()
    if not workspace then
        return
    end

    local next_layout = workspace.tiled_layout == "master" and "dwindle" or "master"
    local workspace_id = workspace.special and tostring(workspace.name) or tostring(workspace.id)
    hl.workspace_rule({ workspace = workspace_id, layout = next_layout })
end, { description = "Toggle Master/Dwindle layout" })

-- Gather normal workspaces once per docking or compositor start. The stable
-- description matches the Corsair over HDMI and USB-C/DP. Manual moves remain
-- available afterward; ordinary config reloads do not gather workspaces.
local corsairDescription = "CORSAIR MEMORY Inc. 34WQHD240-C A958A4231050"
local corsairSelector = "desc:" .. corsairDescription

local function gather_on_corsair()
    local monitor = hl.get_monitor(corsairSelector)
    if not monitor then
        return
    end

    -- Snapshot IDs before moving: an enabled laptop panel needs a replacement
    -- empty workspace, which must not be swept repeatedly. Scratchpads stay separate.
    local workspaceIds = {}
    for _, workspace in ipairs(hl.get_workspaces()) do
        if not workspace.special and (not workspace.monitor or workspace.monitor.id ~= monitor.id) then
            workspaceIds[#workspaceIds + 1] = workspace.id
        end
    end

    for _, id in ipairs(workspaceIds) do
        -- An empty dynamic workspace may have disappeared during an earlier move.
        local workspace = hl.get_workspace(id)
        if workspace and not workspace.special and (not workspace.monitor or workspace.monitor.id ~= monitor.id) then
            hl.dispatch(hl.dsp.workspace.move({ workspace = workspace, monitor = monitor }))
        end
    end
end

hl.on("monitor.added", function(monitor)
    if monitor and monitor.description == corsairDescription then
        gather_on_corsair()
    end
end)
hl.on("hyprland.start", gather_on_corsair)

-- Also allow an explicit one-time gather when enabling this in a running session.
return { gather_on_corsair = gather_on_corsair }
