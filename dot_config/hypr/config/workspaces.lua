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
