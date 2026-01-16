#!/bin/bash
# Waybar module for wezterm mode and tab title

MODE_FILE="/tmp/wezterm-mode"
TITLE_FILE="/tmp/wezterm-title"
MODE="INSERT"
TITLE=""

# Read mode from file if it exists
if [[ -f "$MODE_FILE" ]]; then
    MODE=$(cat "$MODE_FILE")
fi

# Read tab title from file if it exists
if [[ -f "$TITLE_FILE" ]]; then
    TITLE=$(cat "$TITLE_FILE")
fi

# Get active window info from hyprctl
ACTIVE_WINDOW=$(hyprctl activewindow -j 2>/dev/null)

if [[ -n "$ACTIVE_WINDOW" ]]; then
    CLASS=$(echo "$ACTIVE_WINDOW" | jq -r '.class // empty')
    
    # Only show if wezterm is focused
    if [[ "$CLASS" == "org.wezfurlong.wezterm" ]]; then
        # Truncate title if too long
        if [[ ${#TITLE} -gt 40 ]]; then
            TITLE="${TITLE:0:37}..."
        fi
        
        # Output JSON for waybar
        echo "{\"text\": \"[$MODE] $TITLE\", \"class\": \"wezterm-$MODE\", \"tooltip\": \"$TITLE\"}"
    else
        echo "{\"text\": \"\", \"class\": \"hidden\"}"
    fi
else
    echo "{\"text\": \"\", \"class\": \"hidden\"}"
fi
