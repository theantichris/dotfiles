# Cyberpunk Fish Theme

set -g cyberpunk_primary CA0174 # Pink (Accent 0)
set -g cyberpunk_secondary 00F0FF # Bright cyan (Accent 1)
set -g cyberpunk_tertiary FF00FF # Magenta
set -g cyberpunk_quaternary 00FFA2 # Neon green
set -g cyberpunk_success 00FF9C # Green
set -g cyberpunk_warning FFD300 # Yellow
set -g cyberpunk_error FF003C # Red
set -g cyberpunk_text EAEAF2 # Main text
set -g cyberpunk_comment 8A86A0 # Muted text
set -g cyberpunk_highlight CA0174 # Pink

function __cyberpunk_git_status
    if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
        return
    end

    set -l branch (git symbolic-ref --short HEAD 2>/dev/null; or git rev-parse --short HEAD 2>/dev/null)
    set -l status_symbols ""

    # Check for unstaged changes
    git diff --quiet 2>/dev/null
    if test $status -ne 0
        set status_symbols "$status_symbols"(set_color $cyberpunk_warning)" ●"
    end

    # Check for staged changes
    git diff --cached --quiet 2>/dev/null
    if test $status -ne 0
        set status_symbols "$status_symbols"(set_color $cyberpunk_success)" ●"
    end

    # Check for untracked files
    set -l untracked (git ls-files --others --exclude-standard 2>/dev/null)
    if test -n "$untracked"
        set status_symbols "$status_symbols"(set_color $cyberpunk_error)" ●"
    end

    # Check ahead/behind
    set -l ahead_behind (git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null)
    if test -n "$ahead_behind"
        set -l behind (echo $ahead_behind | cut -f1)
        set -l ahead (echo $ahead_behind | cut -f2)

        if test "$behind" -gt 0
            set status_symbols "$status_symbols"(set_color $cyberpunk_quaternary)" ⇣$behind"
        end
        if test "$ahead" -gt 0
            set status_symbols "$status_symbols"(set_color $cyberpunk_tertiary)" ⇡$ahead"
        end
    end

    echo -n " "(set_color $cyberpunk_comment)"["(set_color $cyberpunk_secondary)"$branch$status_symbols"(set_color $cyberpunk_comment)"]"
end

function __cyberpunk_pwd
    set -l pwd_path (string replace -r "^$HOME" "~" $PWD)
    echo -n (set_color $cyberpunk_primary)"$pwd_path"
end

function __cyberpunk_venv
    if test -n "$VIRTUAL_ENV"
        set -l venv_name (basename $VIRTUAL_ENV)
        echo -n (set_color $cyberpunk_comment)"("(set_color $cyberpunk_tertiary)"$venv_name"(set_color $cyberpunk_comment)") "
    end
end

function __cyberpunk_node
    if test -f package.json
        and command -q node
        set -l node_version (node -v 2>/dev/null)
        if test -n "$node_version"
            echo -n (set_color $cyberpunk_comment)"["(set_color $cyberpunk_success)"$node_version"(set_color $cyberpunk_comment)"] "
        end
    end
end

function __cyberpunk_go
    if test -f go.mod
        and command -q go
        set -l go_version (go version | awk '{print $3}' | sed 's/go//')
        echo -n (set_color $cyberpunk_comment)"["(set_color $cyberpunk_secondary)"go$go_version"(set_color $cyberpunk_comment)"] "
    end
end

function __cyberpunk_exit_status
    set -l last_status $status
    if test $last_status -ne 0
        echo -n (set_color $cyberpunk_error)"✗ $last_status "(set_color normal)
    end
end

function __cyberpunk_user_host
    set -l default_user chris

    if test -n "$SSH_CONNECTION"
        echo -n (set_color $cyberpunk_highlight)"$USER"(set_color $cyberpunk_comment)"@"(set_color $cyberpunk_quaternary)"$hostname "(set_color normal)
    else if test "$USER" != "$default_user"
        echo -n (set_color $cyberpunk_warning)"$USER "(set_color normal)
    end
end

function fish_prompt
    set -l last_status $status

    # Store exit status for display
    set -g __cyberpunk_last_status $last_status

    # Build left side content
    set -l left_part (set_color $cyberpunk_primary)"╭─"

    if test $last_status -ne 0
        set left_part "$left_part"(set_color $cyberpunk_error)"✗ $last_status "(set_color normal)
    end

    set left_part "$left_part"(__cyberpunk_user_host)
    set left_part "$left_part"(__cyberpunk_venv)
    set left_part "$left_part"(__cyberpunk_go)
    set left_part "$left_part"(__cyberpunk_node)
    set left_part "$left_part"(__cyberpunk_pwd)
    set left_part "$left_part"(__cyberpunk_git_status)

    # Build right side content (clock icon + time)
    set -l time_str (date "+%H:%M:%S")
    set -l clock_icon \uf017
    set -l right_part (set_color $cyberpunk_comment)" $clock_icon  $time_str"(set_color normal)

    # Calculate visible lengths (without ANSI codes)
    set -l left_len (string length --visible -- "$left_part")
    set -l right_len (string length --visible -- "$right_part")

    # Calculate dot fill width (terminal width - left - right - padding)
    set -l term_width $COLUMNS
    set -l fill_width (math "$term_width - $left_len - $right_len - 1")

    # Generate dot fill
    set -l dots ""
    if test $fill_width -gt 0
        set dots (set_color $cyberpunk_comment)(string repeat -n $fill_width "·")(set_color normal)
    end

    # Line 1: left content + dots + timestamp
    echo "$left_part $dots$right_part"

    # Line 2: Prompt arrows
    echo -n "╰─"(set_color $cyberpunk_primary)"❯"(set_color $cyberpunk_secondary)"❯"(set_color $cyberpunk_tertiary)"❯ "(set_color normal)
end

function fish_right_prompt
    # Intentionally empty - timestamp moved to line 1
end
