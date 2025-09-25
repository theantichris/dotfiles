# Cyberwave ZSH Theme

# Color definitions using your cyberwave palette
typeset -A cyberwave_colors
cyberwave_colors=(
    # Base colors
    [background]="#091a1f"
    [surface_1]="#192a30"
    [surface_2]="#001a24"
    [surface_3]="#08252f"
    [text]="#cdcefb"
    [text_muted]="#bdc2c3"
    [comment]="#8e9395"
    
    # Accents
    [primary]="#16e6c9"      # Bright cyan - main accent
    [secondary]="#26add0"    # Blue - strings/constants
    [tertiary]="#c73df5e3"   # Purple - functions
    [quaternary]="#ff8ffd"   # Pink - operators
    
    # Semantics
    [success]="#23d18b"      # Green - success states
    [warning]="#cca700"      # Yellow - warnings
    [error]="#e25e44"        # Red - errors
    [info]="#75beff"         # Light blue - info
    [link]="#119c82"         # Teal - links
    
    # UI elements
    [border]="#029fec91"
    [shadow]="#5b3199bf"
    [selection]="#264f78"
    [highlight]="#ff349a"
)

# Enable 256 color support
autoload -U colors && colors

# Helper function to get color codes
cyberwave_color() {
    local color_name=$1
    local color_code=${cyberwave_colors[$color_name]}
    
    if [[ -n $color_code ]]; then
        # Convert hex to RGB for terminal
        local r=$(printf "%d" "0x${color_code:1:2}")
        local g=$(printf "%d" "0x${color_code:3:2}")  
        local b=$(printf "%d" "0x${color_code:5:2}")
        echo "%{\033[38;2;${r};${g};${b}m%}"
    else
        echo "%{$fg[white]%}"
    fi
}

# Define color shortcuts
typeset -A CW
CW[primary]=$(cyberwave_color primary)
CW[secondary]=$(cyberwave_color secondary) 
CW[tertiary]=$(cyberwave_color tertiary)
CW[quaternary]=$(cyberwave_color quaternary)
CW[success]=$(cyberwave_color success)
CW[warning]=$(cyberwave_color warning)
CW[error]=$(cyberwave_color error)
CW[text]=$(cyberwave_color text)
CW[text_muted]=$(cyberwave_color text_muted)
CW[comment]=$(cyberwave_color comment)
CW[highlight]=$(cyberwave_color highlight)
CW[reset]="%{$reset_color%}"

# Git status function
cyberwave_git_status() {
    local ref
    if [[ $(command git config --get oh-my-zsh.hide-status 2>/dev/null) != "1" ]]; then
        ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
        ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
        
        local branch=${ref#refs/heads/}
        local git_status=""
        local status_symbols=""
        
        # Check for changes
        if ! git diff --quiet 2>/dev/null; then
            status_symbols+="${CW[warning]}●${CW[reset]}"
        fi
        
        # Check for staged changes
        if ! git diff --cached --quiet 2>/dev/null; then
            status_symbols+="${CW[success]}●${CW[reset]}"
        fi
        
        # Check for untracked files
        if [[ -n $(git ls-files --others --exclude-standard 2>/dev/null) ]]; then
            status_symbols+="${CW[error]}●${CW[reset]}"
        fi
        
        # Check if ahead/behind remote
        local ahead_behind=$(git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null)
        if [[ -n $ahead_behind ]]; then
            local behind=$(echo $ahead_behind | cut -f1)
            local ahead=$(echo $ahead_behind | cut -f2)
            
            if [[ $behind -gt 0 ]]; then
                status_symbols+="${CW[quaternary]}⇣${behind}${CW[reset]}"
            fi
            if [[ $ahead -gt 0 ]]; then
                status_symbols+="${CW[tertiary]}⇡${ahead}${CW[reset]}"
            fi
        fi
        
        git_status=" ${CW[comment]}[${CW[secondary]}${branch}${status_symbols}${CW[comment]}]${CW[reset]}"
    fi
    echo $git_status
}

# Directory path with smart truncation
cyberwave_pwd() {
    local pwd_path=$(pwd)
    local home_replaced=${pwd_path/#$HOME/\~}
    
    # If path is too long, show first and last parts
    if [[ ${#home_replaced} -gt 40 ]]; then
        local path_parts=(${(s:/:)home_replaced})
        if [[ ${#path_parts} -gt 3 ]]; then
            echo "${CW[primary]}${path_parts[1]}/${CW[comment]}.../${CW[primary]}${path_parts[-1]}${CW[reset]}"
        else
            echo "${CW[primary]}${home_replaced}${CW[reset]}"
        fi
    else
        echo "${CW[primary]}${home_replaced}${CW[reset]}"
    fi
}

# Command execution time
cyberwave_exec_time() {
    if [[ -n $cyberwave_cmd_timestamp ]]; then
        local stop=$(date +%s)
        local start=$cyberwave_cmd_timestamp
        local elapsed=$((stop - start))
        
        unset cyberwave_cmd_timestamp
        
        if [[ $elapsed -gt 2 ]]; then
            echo " ${CW[comment]}took ${CW[warning]}${elapsed}s${CW[reset]}"
        fi
    fi
}

# Pre-command hook to capture timestamp
cyberwave_preexec() {
    cyberwave_cmd_timestamp=$(date +%s)
}

# Virtual environment indicator
cyberwave_venv() {
    if [[ -n $VIRTUAL_ENV ]]; then
        local venv_name=$(basename $VIRTUAL_ENV)
        echo "${CW[comment]}(${CW[tertiary]}${venv_name}${CW[comment]}) ${CW[reset]}"
    fi
}

# Node version (if using nvm/node)
cyberwave_node() {
    if command -v node &> /dev/null && [[ -f package.json ]]; then
        local node_version=$(node -v 2>/dev/null)
        if [[ -n $node_version ]]; then
            echo "${CW[comment]}[${CW[success]}${node_version}${CW[comment]}] ${CW[reset]}"
        fi
    fi
}

# Go version (if in Go project)
cyberwave_go() {
    if command -v go &> /dev/null && [[ -f go.mod ]]; then
        local go_version=$(go version | awk '{print $3}' | sed 's/go//')
        echo "${CW[comment]}[${CW[secondary]}go${go_version}${CW[comment]}] ${CW[reset]}"
    fi
}

# Last command exit status
cyberwave_exit_status() {
    local exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
        echo "${CW[error]}✗ ${exit_code}${CW[reset]} "
    fi
}

# User and host (only show if SSH or different user)
cyberwave_user_host() {
    local user_host=""
    if [[ -n $SSH_CONNECTION ]] || [[ $USER != "chris" ]]; then
        if [[ -n $SSH_CONNECTION ]]; then
            user_host="${CW[highlight]}${USER}${CW[comment]}@${CW[quaternary]}${HOST}${CW[reset]} "
        else
            user_host="${CW[warning]}${USER}${CW[reset]} "
        fi
    fi
    echo $user_host
}

# Main prompt
cyberwave_main_prompt() {
    local prompt_parts=""
    
    # User/host (if needed)
    prompt_parts+="$(cyberwave_user_host)"
    
    # Virtual environment
    prompt_parts+="$(cyberwave_venv)"
    
    # Language versions (context-aware)
    prompt_parts+="$(cyberwave_go)"
    prompt_parts+="$(cyberwave_node)"
    
    # Current directory
    prompt_parts+="$(cyberwave_pwd)"
    
    # Git status
    prompt_parts+="$(cyberwave_git_status)"
    
    # Execution time
    prompt_parts+="$(cyberwave_exec_time)"
    
    echo $prompt_parts
}

# Right-side prompt (optional)
cyberwave_rprompt() {
    local time_stamp="${CW[comment]}%D{%H:%M:%S}${CW[reset]}"
    echo $time_stamp
}

# Setup hooks
autoload -Uz add-zsh-hook
add-zsh-hook preexec cyberwave_preexec

# Set the prompts
setopt prompt_subst

# Main prompt with cyberpunk styling
PROMPT='
╭─$(cyberwave_exit_status)$(cyberwave_main_prompt)
╰─${CW[primary]}❯${CW[secondary]}❯${CW[tertiary]}❯${CW[reset]} '

# Right prompt
RPROMPT='$(cyberwave_rprompt)'

# Continuation prompt (for multi-line commands)
PROMPT2='${CW[comment]}│ ${CW[reset]}'

# Selection prompt
PROMPT3='${CW[quaternary]}?# ${CW[reset]}'

# Debug prompt
PROMPT4='${CW[warning]}+%N:%i${CW[reset]}> '

# Clean up on theme switch
if [[ -n $cyberwave_cleanup ]]; then
    unset cyberwave_cleanup
    unset -f cyberwave_color cyberwave_git_status cyberwave_pwd cyberwave_exec_time
    unset -f cyberwave_preexec cyberwave_venv cyberwave_node cyberwave_go 
    unset -f cyberwave_exit_status cyberwave_user_host cyberwave_main_prompt cyberwave_rprompt
    unset cyberwave_colors CW cyberwave_cmd_timestamp
fi

# Set cleanup flag for next theme switch
cyberwave_cleanup=true
