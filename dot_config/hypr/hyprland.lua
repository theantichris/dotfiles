-- CachyOS Hyprland Configuration

require("config.animations")
require("config.autostart")
require("config.colors")
require("config.decorations")
require("config.variables")
require("config.environment")
require("config.inputs")
require("config.binds")
require("config.misc")
require("config.monitors")
require("config.windowrules")
require("config.workspaces")

-- For Noctalia Color templates
-- Kept here deliberately: Noctalia's hyprland template post-hook appends this
-- line itself, which chezmoi would then revert on the next apply.
require("noctalia").apply_theme()
