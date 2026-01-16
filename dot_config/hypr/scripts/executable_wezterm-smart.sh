#!/bin/bash
# Open WezTerm in the CWD of existing WezTerm, or ~ if none exists

# Find a WezTerm window PID
wezterm_pid=$(hyprctl clients -j | jq -r '.[] | select(.class == "org.wezfurlong.wezterm") | .pid' | head -n1)

if [[ -n "$wezterm_pid" ]]; then
    # Get the child shell process (fish/bash/zsh)
    child_pid=$(pgrep -P "$wezterm_pid" | head -n1)
    if [[ -n "$child_pid" ]]; then
        # Get the CWD of the shell process
        cwd=$(readlink -f "/proc/$child_pid/cwd" 2>/dev/null)
        if [[ -d "$cwd" ]]; then
            exec wezterm start --cwd "$cwd"
        fi
    fi
fi

# Fallback to home directory
exec wezterm start --cwd "$HOME"
