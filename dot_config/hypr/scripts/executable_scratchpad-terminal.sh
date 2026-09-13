#!/bin/bash
set -euo pipefail

workspace="terminal"
class="kitty-scratchpad"
special_workspace="special:${workspace}"

# If the scratchpad is already visible, just hide it.
if hyprctl monitors -j | jq -e --arg ws "$special_workspace" '.[] | select(.specialWorkspace.name == $ws)' >/dev/null; then
    hyprctl dispatch togglespecialworkspace "$workspace" >/dev/null
    exit 0
fi

# Start the dedicated Kitty if it does not exist yet, then wait briefly for
# Hyprland to see it before revealing the special workspace.
if ! hyprctl clients -j | jq -e --arg class "$class" '.[] | select(.class == $class)' >/dev/null; then
    uwsm app -- kitty --class "$class" >/dev/null 2>&1 &
    for _ in {1..40}; do
        if hyprctl clients -j | jq -e --arg class "$class" '.[] | select(.class == $class)' >/dev/null; then
            break
        fi
        sleep 0.025
    done
fi

hyprctl dispatch togglespecialworkspace "$workspace" >/dev/null
sleep 0.03
hyprctl dispatch focuswindow "class:^(${class})$" >/dev/null
