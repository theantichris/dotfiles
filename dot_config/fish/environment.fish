# Done command
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level_low

set -Ux BROWSER firefox
set -Ux TERM wezterm

set -Ux SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
ssh-add ~/.ssh/github_ed25519 &>/dev/null
