#!/bin/bash

# Cyberpunk theme colors
PRIMARY="\033[38;2;202;1;116m"      # Pink #CA0174
SECONDARY="\033[38;2;0;240;255m"    # Cyan #00F0FF
TERTIARY="\033[38;2;255;0;255m"     # Magenta #FF00FF
QUATERNARY="\033[38;2;0;255;162m"   # Neon green #00FFA2
SUCCESS="\033[38;2;0;255;156m"      # Green #00FF9C
WARNING="\033[38;2;255;211;0m"      # Yellow #FFD300
ERROR="\033[38;2;255;0;60m"         # Red #FF003C
COMMENT="\033[38;2;138;134;160m"    # Muted #8A86A0
RESET="\033[0m"

# Read JSON input
input=$(cat)

# Extract current directory
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
pwd_path="${cwd/#$HOME/~}"

# Extract Claude session info
model=$(echo "$input" | jq -r '.model.display_name // empty')
context_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // empty')

# Format duration
format_duration() {
    local ms=$1
    if [ -z "$ms" ] || [ "$ms" = "null" ]; then
        echo ""
        return
    fi
    local total_secs=$((ms / 1000))
    local hours=$((total_secs / 3600))
    local mins=$(((total_secs % 3600) / 60))
    if [ "$hours" -gt 0 ]; then
        echo "${hours}h${mins}m"
    else
        echo "${mins}m"
    fi
}
duration=$(format_duration "$duration_ms")

# Git status function
git_status() {
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        return
    fi

    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
    status_symbols=""

    # Check for unstaged changes
    if ! git diff --quiet 2>/dev/null; then
        status_symbols="${status_symbols}${WARNING} ●${RESET}"
    fi

    # Check for staged changes
    if ! git diff --cached --quiet 2>/dev/null; then
        status_symbols="${status_symbols}${SUCCESS} ●${RESET}"
    fi

    # Check for untracked files
    if [ -n "$(git ls-files --others --exclude-standard 2>/dev/null)" ]; then
        status_symbols="${status_symbols}${ERROR} ●${RESET}"
    fi

    # Check ahead/behind
    ahead_behind=$(git -c core.fileMode=false rev-list --count --left-right '@{upstream}...HEAD' 2>/dev/null)
    if [ -n "$ahead_behind" ]; then
        behind=$(echo "$ahead_behind" | cut -f1)
        ahead=$(echo "$ahead_behind" | cut -f2)

        if [ "$behind" -gt 0 ]; then
            status_symbols="${status_symbols}${QUATERNARY} ⇣$behind${RESET}"
        fi
        if [ "$ahead" -gt 0 ]; then
            status_symbols="${status_symbols}${TERTIARY} ⇡$ahead${RESET}"
        fi
    fi

    printf " ${COMMENT}[${RESET}${SECONDARY}%s%b${RESET}${COMMENT}]${RESET}" "$branch" "$status_symbols"
}

# Build status line
printf "${PRIMARY}%s${RESET}" "$pwd_path"
git_status

# Claude session info
if [ -n "$model" ]; then
    printf " ${COMMENT}//${RESET} ${TERTIARY}%s${RESET}" "$model"
fi
if [ -n "$context_pct" ]; then
    printf " ${COMMENT}//${RESET} ${SECONDARY}%s%%${RESET}" "$context_pct"
fi
if [ -n "$duration" ]; then
    printf " ${COMMENT}//${RESET} ${COMMENT}%s${RESET}" "$duration"
fi
printf " "
