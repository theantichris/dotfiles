# Cyberwave Terminal Splash Screen
# Displays a cyberpunk-themed circuit pattern with system information

cyberwave_splash() {
    # Use direct ANSI escape codes instead of zsh prompt escapes
    local c_primary=$'\033[38;2;22;230;201m'    # #16e6c9
    local c_secondary=$'\033[38;2;38;173;208m'  # #26add0
    local c_tertiary=$'\033[38;2;199;61;245m'   # #c73df5
    local c_quaternary=$'\033[38;2;255;143;253m' # #ff8ffd
    local c_success=$'\033[38;2;35;209;139m'    # #23d18b
    local c_warning=$'\033[38;2;204;167;0m'     # #cca700
    local c_comment=$'\033[38;2;142;147;149m'   # #8e9395
    local c_highlight=$'\033[38;2;255;52;154m'  # #ff349a
    local c_reset=$'\033[0m'

    # Get system information
    local os_info="$(uname -s) $(uname -r)"
    local kernel_info="$(uname -v | awk '{print $1}')"
    local shell_info="$SHELL ($(zsh --version 2>/dev/null | awk '{print $2}'))"
    local terminal_info="${TERM_PROGRAM:-$TERM}"

    # Get uptime in a readable format
    local uptime_raw="$(uptime)"
    local uptime_formatted=""
    if [[ "$OSTYPE" == "darwin"* ]]; then
        uptime_formatted=$(echo "$uptime_raw" | sed -E 's/.*up ([^,]+).*/\1/' | xargs)
    else
        uptime_formatted=$(echo "$uptime_raw" | sed -E 's/.*up ([^,]+).*/\1/' | xargs)
    fi

    # Get user and hostname (truncate if too long)
    local hostname="${HOST}"
    # Truncate hostname if it's too long
    if [[ ${#hostname} -gt 20 ]]; then
        hostname="${hostname:0:17}..."
    fi
    local user_host="${USER}@${hostname}"
    if [[ -n "$SSH_CONNECTION" ]]; then
        user_host="${c_highlight}${USER}${c_comment}@${c_quaternary}${hostname}${c_reset}"
    fi

    # Get CPU usage
    local cpu_usage=""
    if [[ "$OSTYPE" == "darwin"* ]]; then
        cpu_usage=$(ps aux | awk '{sum+=$3} END {printf "%.0f", sum}')
    else
        cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1 | cut -d'.' -f1)
    fi

    # Create CPU bar graph
    local cpu_bar=""
    local cpu_percent=$((cpu_usage))
    local bar_width=20
    local filled=$((cpu_percent * bar_width / 100))
    for ((i=0; i<bar_width; i++)); do
        if [[ $i -lt $filled ]]; then
            cpu_bar+="█"
        else
            cpu_bar+="░"
        fi
    done

    # Get memory usage
    local mem_info=""
    local mem_bar=""
    if [[ "$OSTYPE" == "darwin"* ]]; then
        local mem_total=$(sysctl -n hw.memsize | awk '{printf "%.1f", $1/1024/1024/1024}')
        local pages_free=$(vm_stat | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
        local pages_inactive=$(vm_stat | grep "Pages inactive" | awk '{print $3}' | sed 's/\.//')
        local pages_size=4096
        local mem_free=$(echo "scale=1; ($pages_free + $pages_inactive) * $pages_size / 1024 / 1024 / 1024" | bc)
        local mem_used=$(echo "scale=1; $mem_total - $mem_free" | bc)
        mem_info="${mem_used}GB / ${mem_total}GB"

        local mem_percent=$(echo "scale=0; $mem_used * 100 / $mem_total" | bc)
        filled=$((mem_percent * bar_width / 100))
        for ((i=0; i<bar_width; i++)); do
            if [[ $i -lt $filled ]]; then
                mem_bar+="█"
            else
                mem_bar+="░"
            fi
        done
    else
        mem_info=$(free -h | awk 'NR==2 {print $3 " / " $2}')
        local mem_percent=$(free | awk 'NR==2 {printf "%.0f", $3*100/$2}')
        filled=$((mem_percent * bar_width / 100))
        for ((i=0; i<bar_width; i++)); do
            if [[ $i -lt $filled ]]; then
                mem_bar+="█"
            else
                mem_bar+="░"
            fi
        done
    fi

    # Get disk usage
    local disk_info=$(df -h ~ | awk 'NR==2 {print $3 " / " $2}')
    local disk_percent=$(df ~ | awk 'NR==2 {gsub(/%/, "", $5); print $5}')
    local disk_bar=""
    filled=$((disk_percent * bar_width / 100))
    for ((i=0; i<bar_width; i++)); do
        if [[ $i -lt $filled ]]; then
            disk_bar+="█"
        else
            disk_bar+="░"
        fi
    done

    # Get network info
    local net_info=""
    if [[ "$OSTYPE" == "darwin"* ]]; then
        local active_if=$(route get default 2>/dev/null | grep interface | awk '{print $2}')
        if [[ -n "$active_if" ]]; then
            local ip_addr=$(ifconfig "$active_if" 2>/dev/null | grep "inet " | awk '{print $2}')
            net_info="${active_if}: ${ip_addr:-no IP}"
        else
            net_info="No network"
        fi
    else
        local ip_addr=$(ip route get 1.1.1.1 2>/dev/null | awk '{print $7; exit}')
        local active_if=$(ip route get 1.1.1.1 2>/dev/null | awk '{print $5; exit}')
        if [[ -n "$active_if" ]]; then
            net_info="${active_if}: ${ip_addr:-no IP}"
        else
            net_info="No network"
        fi
    fi

    # Get current date and time
    local date_time=$(date "+%Y.%m.%d :: %H:%M:%S")

    # Print the splash screen with proper formatting
    echo ""
    echo "         ${c_primary}╔═══${c_secondary}◉${c_primary}═══════════════════════════${c_secondary}◉${c_primary}═══╗${c_reset}"
    echo "         ${c_primary}║${c_reset}    ${c_tertiary}C Y B E R W A V E${c_reset}  ${c_quaternary}S Y S${c_reset}    ${c_primary}║${c_reset}"
    echo "    ${c_primary}═════${c_comment}╬${c_primary}═══${c_tertiary}◈${c_primary}═══════════════════════${c_tertiary}◈${c_primary}═══${c_comment}╬${c_primary}═════${c_reset}"
    echo "         ${c_primary}║${c_reset}                                 ${c_primary}║${c_reset}"
    echo "    ${c_comment}┬────${c_secondary}◉${c_comment}──┬──────┬────────┬──────┬──${c_secondary}◉${c_comment}────┬${c_reset}"
    echo "    ${c_comment}│${c_reset}      ${c_quaternary}▓░░▒${c_reset}   ${c_tertiary}SYSTEM${c_reset}    ${c_quaternary}▒░░▓${c_reset}      ${c_comment}│${c_reset}"
    echo "    ${c_comment}├────${c_tertiary}◈${c_comment}──┼──────┼────────┼──────┼──${c_tertiary}◈${c_comment}────┤${c_reset}"
    echo "    ${c_comment}│${c_reset}                                     ${c_comment}│${c_reset}"
    printf "    ${c_comment}│${c_reset}  ${c_success}⬡${c_reset} OS:       ${c_secondary}%-26s${c_reset} ${c_comment}│${c_reset}\n" "${os_info}"
    printf "    ${c_comment}│${c_reset}  ${c_success}⬡${c_reset} Kernel:   ${c_secondary}%-26s${c_reset} ${c_comment}│${c_reset}\n" "${kernel_info}"
    printf "    ${c_comment}│${c_reset}  ${c_success}⬡${c_reset} Shell:    ${c_secondary}%-26s${c_reset} ${c_comment}│${c_reset}\n" "${shell_info}"
    printf "    ${c_comment}│${c_reset}  ${c_success}⬡${c_reset} Terminal: ${c_secondary}%-26s${c_reset} ${c_comment}│${c_reset}\n" "${terminal_info}"
    printf "    ${c_comment}│${c_reset}  ${c_success}⬡${c_reset} Uptime:   ${c_secondary}%-26s${c_reset} ${c_comment}│${c_reset}\n" "${uptime_formatted}"
    printf "    ${c_comment}│${c_reset}  ${c_success}⬡${c_reset} User:     ${c_secondary}%-26s${c_reset} ${c_comment}│${c_reset}\n" "${user_host}"
    echo "    ${c_comment}│${c_reset}                                     ${c_comment}│${c_reset}"
    echo "    ${c_comment}├────${c_secondary}◉${c_comment}──┬──────┬────────┬──────┬──${c_secondary}◉${c_comment}────┤${c_reset}"
    echo "    ${c_comment}│${c_reset}      ${c_quaternary}▓░░▒${c_reset}  ${c_tertiary}RESOURCES${c_reset}  ${c_quaternary}▒░░▓${c_reset}      ${c_comment}│${c_reset}"
    echo "    ${c_comment}├────${c_tertiary}◈${c_comment}──┼──────┼────────┼──────┼──${c_tertiary}◈${c_comment}────┤${c_reset}"
    echo "    ${c_comment}│${c_reset}                                     ${c_comment}│${c_reset}"
    printf "    ${c_comment}│${c_reset}  ${c_warning}▣${c_reset} CPU:  %3s%% ${c_primary}%-20s${c_reset}    ${c_comment}│${c_reset}\n" "${cpu_usage}" "${cpu_bar}"
    printf "    ${c_comment}│${c_reset}  ${c_warning}▣${c_reset} RAM:  %-16s ${c_secondary}%-20s${c_reset} ${c_comment}│${c_reset}\n" "${mem_info}" "${mem_bar}"
    printf "    ${c_comment}│${c_reset}  ${c_warning}▣${c_reset} Disk: %-16s ${c_tertiary}%-20s${c_reset} ${c_comment}│${c_reset}\n" "${disk_info}" "${disk_bar}"
    printf "    ${c_comment}│${c_reset}  ${c_warning}▣${c_reset} Net:  ${c_secondary}%-26s${c_reset}        ${c_comment}│${c_reset}\n" "${net_info}"
    echo "    ${c_comment}│${c_reset}                                     ${c_comment}│${c_reset}"
    echo "    ${c_comment}┴────${c_secondary}◉${c_comment}──┴──────┴────────┴──────┴──${c_secondary}◉${c_comment}────┴${c_reset}"
    echo "         ${c_primary}║${c_reset}                                 ${c_primary}║${c_reset}"
    echo "    ${c_primary}═════${c_comment}╬${c_primary}═══${c_tertiary}◈${c_primary}═══════════════════════${c_tertiary}◈${c_primary}═══${c_comment}╬${c_primary}═════${c_reset}"
    echo "         ${c_primary}║${c_reset}  ${c_quaternary}${date_time}${c_reset}         ${c_primary}║${c_reset}"
    echo "         ${c_primary}╚═══${c_secondary}◉${c_primary}═══════════════════════════${c_secondary}◉${c_primary}═══╝${c_reset}"
    echo ""
}