# Cyberwave Terminal Splash Screen - Simple & Clean
cyberwave_splash() {
    # Colors
    local cyan=$'\033[38;2;22;230;201m'      # #16e6c9
    local blue=$'\033[38;2;38;173;208m'      # #26add0  
    local purple=$'\033[38;2;199;61;245m'    # #c73df5
    local pink=$'\033[38;2;255;143;253m'     # #ff8ffd
    local green=$'\033[38;2;35;209;139m'     # #23d18b
    local yellow=$'\033[38;2;204;167;0m'     # #cca700
    local gray=$'\033[38;2;142;147;149m'     # #8e9395
    local reset=$'\033[0m'

    # Get system info
    local os="$(uname -s)"
    local user="${USER}"
    local host="${HOST%%.*}"  # Remove domain
    local shell_name="${SHELL##*/}"
    local uptime=$(uptime | sed 's/.*up \([^,]*\).*/\1/' | xargs)
    
    # Simple CPU check
    local cpu="N/A"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        cpu=$(ps aux | awk '{sum+=$3} END {printf "%.0f%%", sum}' 2>/dev/null || echo "N/A")
    elif command -v top >/dev/null; then
        cpu=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' 2>/dev/null || echo "N/A")
    fi

    echo ""
    echo "    ${cyan}╔══════════════════════════════════════╗${reset}"
    echo "    ${cyan}║${reset}                                      ${cyan}║${reset}"
    echo "    ${cyan}║${reset}       ${purple}C Y B E R W A V E${reset}          ${cyan}║${reset}"
    echo "    ${cyan}║${reset}                                      ${cyan}║${reset}"
    echo "    ${cyan}╠══════════════════════════════════════╣${reset}"
    echo "    ${cyan}║${reset}                                      ${cyan}║${reset}"
    printf "    ${cyan}║${reset}  ${green}⬢${reset} System:  %-20s    ${cyan}║${reset}\n" "$os"
    printf "    ${cyan}║${reset}  ${green}⬢${reset} User:    %-20s    ${cyan}║${reset}\n" "$user@$host" 
    printf "    ${cyan}║${reset}  ${green}⬢${reset} Shell:   %-20s    ${cyan}║${reset}\n" "$shell_name"
    printf "    ${cyan}║${reset}  ${green}⬢${reset} Uptime:  %-20s    ${cyan}║${reset}\n" "$uptime"
    printf "    ${cyan}║${reset}  ${green}⬢${reset} CPU:     %-20s    ${cyan}║${reset}\n" "$cpu"
    echo "    ${cyan}║${reset}                                      ${cyan}║${reset}"
    echo "    ${cyan}╠══════════════════════════════════════╣${reset}"
    echo "    ${cyan}║${reset}                                      ${cyan}║${reset}"
    printf "    ${cyan}║${reset}        ${blue}%s${reset}          ${cyan}║${reset}\n" "$(date '+%Y.%m.%d :: %H:%M:%S')"
    echo "    ${cyan}║${reset}                                      ${cyan}║${reset}"
    echo "    ${cyan}╚══════════════════════════════════════╝${reset}"
    echo ""
    echo "    ${gray}> Initializing cyberwave environment...${reset}"
    echo ""
}
