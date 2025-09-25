# Cyberwave Terminal Splash Screen
# Displays a cyberpunk-themed circuit pattern with system information

cyberwave_splash() {
    # Get system information
    local os_info="$(uname -s) $(uname -r)"
    local kernel_info="$(uname -v | awk '{print $1}')"
    local shell_info="$SHELL ($(zsh --version 2>/dev/null | awk '{print $2}'))"
    local terminal_info="${TERM_PROGRAM:-$TERM}"

    # Get uptime in a readable format
    local uptime_raw="$(uptime)"
    local uptime_formatted=""
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS format: "14:32  up 14 days,  3:42, 2 users, load averages: 1.42 1.36 1.33"
        uptime_formatted=$(echo "$uptime_raw" | sed -E 's/.*up ([^,]+).*/\1/' | xargs)
    else
        # Linux format
        uptime_formatted=$(echo "$uptime_raw" | sed -E 's/.*up ([^,]+).*/\1/' | xargs)
    fi

    # Get user and hostname
    local user_host="${USER}@${HOST}"
    if [[ -n "$SSH_CONNECTION" ]]; then
        user_host="${CW[highlight]}${USER}${CW[comment]}@${CW[quaternary]}${HOST}${CW[reset]}"
    fi

    # Get CPU usage (macOS uses different command than Linux)
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
        # macOS memory calculation
        local mem_total=$(sysctl -n hw.memsize | awk '{printf "%.1f", $1/1024/1024/1024}')
        local pages_free=$(vm_stat | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
        local pages_inactive=$(vm_stat | grep "Pages inactive" | awk '{print $3}' | sed 's/\.//')
        local pages_size=4096  # Page size in bytes
        local mem_free=$(echo "scale=1; ($pages_free + $pages_inactive) * $pages_size / 1024 / 1024 / 1024" | bc)
        local mem_used=$(echo "scale=1; $mem_total - $mem_free" | bc)
        mem_info="${mem_used}GB / ${mem_total}GB"

        # Memory bar
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
        # Linux memory
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

    # Get disk usage for home directory
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

    # Get network interface and IP
    local net_info=""
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # Get active network interface on macOS
        local active_if=$(route get default 2>/dev/null | grep interface | awk '{print $2}')
        if [[ -n "$active_if" ]]; then
            local ip_addr=$(ifconfig "$active_if" 2>/dev/null | grep "inet " | awk '{print $2}')
            net_info="${active_if}: ${ip_addr:-no IP}"
        else
            net_info="No network"
        fi
    else
        # Linux network info
        local ip_addr=$(ip route get 1.1.1.1 2>/dev/null | awk '{print $7; exit}')
        local active_if=$(ip route get 1.1.1.1 2>/dev/null | awk '{print $5; exit}')
        if [[ -n "$active_if" ]]; then
            net_info="${active_if}: ${ip_addr:-no IP}"
        else
            net_info="No network"
        fi
    fi

    # Get current date and time in cyberpunk format
    local date_time=$(date "+%Y.%m.%d :: %H:%M:%S")

    # Print the splash screen
    echo ""
    echo "         ${CW[primary]}╔═══${CW[secondary]}◉${CW[primary]}═══════════════════════════${CW[secondary]}◉${CW[primary]}═══╗${CW[reset]}"
    echo "         ${CW[primary]}║${CW[reset]}    ${CW[tertiary]}C Y B E R W A V E${CW[reset]}  ${CW[quaternary]}S Y S${CW[reset]}    ${CW[primary]}║${CW[reset]}"
    echo "    ${CW[primary]}═════${CW[comment]}╬${CW[primary]}═══${CW[tertiary]}◈${CW[primary]}═══════════════════════${CW[tertiary]}◈${CW[primary]}═══${CW[comment]}╬${CW[primary]}═════${CW[reset]}"
    echo "         ${CW[primary]}║${CW[reset]}                                 ${CW[primary]}║${CW[reset]}"
    echo "    ${CW[comment]}┬────${CW[secondary]}◉${CW[comment]}──┬──────┬────────┬──────┬──${CW[secondary]}◉${CW[comment]}────┬${CW[reset]}"
    echo "    ${CW[comment]}│${CW[reset]}      ${CW[quaternary]}▓░░▒${CW[reset]}   ${CW[tertiary]}SYSTEM${CW[reset]}    ${CW[quaternary]}▒░░▓${CW[reset]}      ${CW[comment]}│${CW[reset]}"
    echo "    ${CW[comment]}├────${CW[tertiary]}◈${CW[comment]}──┼──────┼────────┼──────┼──${CW[tertiary]}◈${CW[comment]}────┤${CW[reset]}"
    echo "    ${CW[comment]}│${CW[reset]}                                     ${CW[comment]}│${CW[reset]}"
    echo "    ${CW[comment]}│${CW[reset]}  ${CW[success]}⬡${CW[reset]} OS:       ${CW[secondary]}${os_info}${CW[reset]}    ${CW[comment]}│${CW[reset]}"
    echo "    ${CW[comment]}│${CW[reset]}  ${CW[success]}⬡${CW[reset]} Kernel:   ${CW[secondary]}${kernel_info}${CW[reset]}                 ${CW[comment]}│${CW[reset]}"
    echo "    ${CW[comment]}│${CW[reset]}  ${CW[success]}⬡${CW[reset]} Shell:    ${CW[secondary]}${shell_info}${CW[reset]}                ${CW[comment]}│${CW[reset]}"
    echo "    ${CW[comment]}│${CW[reset]}  ${CW[success]}⬡${CW[reset]} Terminal: ${CW[secondary]}${terminal_info}${CW[reset]}                 ${CW[comment]}│${CW[reset]}"
    echo "    ${CW[comment]}│${CW[reset]}  ${CW[success]}⬡${CW[reset]} Uptime:   ${CW[secondary]}${uptime_formatted}${CW[reset]}            ${CW[comment]}│${CW[reset]}"
    echo "    ${CW[comment]}│${CW[reset]}  ${CW[success]}⬡${CW[reset]} User:     ${CW[secondary]}${user_host}${CW[reset]}        ${CW[comment]}│${CW[reset]}"
    echo "    ${CW[comment]}│${CW[reset]}                                     ${CW[comment]}│${CW[reset]}"
    echo "    ${CW[comment]}├────${CW[secondary]}◉${CW[comment]}──┬──────┬────────┬──────┬──${CW[secondary]}◉${CW[comment]}────┤${CW[reset]}"
    echo "    ${CW[comment]}│${CW[reset]}      ${CW[quaternary]}▓░░▒${CW[reset]}  ${CW[tertiary]}RESOURCES${CW[reset]}  ${CW[quaternary]}▒░░▓${CW[reset]}      ${CW[comment]}│${CW[reset]}"
    echo "    ${CW[comment]}├────${CW[tertiary]}◈${CW[comment]}──┼──────┼────────┼──────┼──${CW[tertiary]}◈${CW[comment]}────┤${CW[reset]}"
    echo "    ${CW[comment]}│${CW[reset]}                                     ${CW[comment]}│${CW[reset]}"
    echo "    ${CW[comment]}│${CW[reset]}  ${CW[warning]}▣${CW[reset]} CPU:  ${cpu_usage}% ${CW[primary]}${cpu_bar}${CW[reset]}    ${CW[comment]}│${CW[reset]}"
    echo "    ${CW[comment]}│${CW[reset]}  ${CW[warning]}▣${CW[reset]} RAM:  ${mem_info}  ${CW[secondary]}${mem_bar}${CW[reset]} ${CW[comment]}│${CW[reset]}"
    echo "    ${CW[comment]}│${CW[reset]}  ${CW[warning]}▣${CW[reset]} Disk: ${disk_info}  ${CW[tertiary]}${disk_bar}${CW[reset]} ${CW[comment]}│${CW[reset]}"
    echo "    ${CW[comment]}│${CW[reset]}  ${CW[warning]}▣${CW[reset]} Net:  ${CW[secondary]}${net_info}${CW[reset]}        ${CW[comment]}│${CW[reset]}"
    echo "    ${CW[comment]}│${CW[reset]}                                     ${CW[comment]}│${CW[reset]}"
    echo "    ${CW[comment]}┴────${CW[secondary]}◉${CW[comment]}──┴──────┴────────┴──────┴──${CW[secondary]}◉${CW[comment]}────┴${CW[reset]}"
    echo "         ${CW[primary]}║${CW[reset]}                                 ${CW[primary]}║${CW[reset]}"
    echo "    ${CW[primary]}═════${CW[comment]}╬${CW[primary]}═══${CW[tertiary]}◈${CW[primary]}═══════════════════════${CW[tertiary]}◈${CW[primary]}═══${CW[comment]}╬${CW[primary]}═════${CW[reset]}"
    echo "         ${CW[primary]}║${CW[reset]}  ${CW[quaternary]}${date_time}${CW[reset]}         ${CW[primary]}║${CW[reset]}"
    echo "         ${CW[primary]}╚═══${CW[secondary]}◉${CW[primary]}═══════════════════════════${CW[secondary]}◉${CW[primary]}═══╝${CW[reset]}"
    echo ""
}