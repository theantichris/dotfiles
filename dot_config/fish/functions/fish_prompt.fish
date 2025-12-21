# Cyberpunk Fish Theme

set -g cyberwave_primary 00F0FF # Bright cyan
set -g cyberwave_secondary CA0174 # Pink
set -g cyberwave_tertiary FF00FF # Magenta
set -g cyberwave_quaternary 00FFA2 # Neon green
set -g cyberwave_success 00FF9C # Green
set -g cyberwave_warning FFD300 # Yellow
set -g cyberwave_error FF003C # Red
set -g cyberwave_text EAEAF2 # Main text
set -g cyberwave_comment 8A86A0 # Muted text
set -g cyberwave_highlight CA0174 # Pink

function __cyberwave_git_status
    if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
        return
    end

    set -l branch (git symbolic-ref --short HEAD 2>/dev/null; or git rev-parse --short HEAD 2>/dev/null)
    set -l status_symbols ""

    # Check for unstaged changes
    git diff --quiet 2>/dev/null
    if test $status -ne 0
        set status_symbols "$status_symbols"(set_color $cyberwave_warning)" ●"
    end

    # Check for staged changes
    git diff --cached --quiet 2>/dev/null
    if test $status -ne 0
        set status_symbols "$status_symbols"(set_color $cyberwave_success)" ●"
    end

    # Check for untracked files
    set -l untracked (git ls-files --others --exclude-standard 2>/dev/null)
    if test -n "$untracked"
        set status_symbols "$status_symbols"(set_color $cyberwave_error)" ●"
    end

    # Check ahead/behind
    set -l ahead_behind (git rev-list --count --left-right @{upstream}...HEAD 2>/dev/null)
    if test -n "$ahead_behind"
        set -l behind (echo $ahead_behind | cut -f1)
        set -l ahead (echo $ahead_behind | cut -f2)

        if test "$behind" -gt 0
            set status_symbols "$status_symbols"(set_color $cyberwave_quaternary)" ⇣$behind"
        end
        if test "$ahead" -gt 0
            set status_symbols "$status_symbols"(set_color $cyberwave_tertiary)" ⇡$ahead"
        end
    end

    echo -n " "(set_color $cyberwave_comment)"["(set_color $cyberwave_secondary)"$branch$status_symbols"(set_color $cyberwave_comment)"]"
end

function __cyberwave_pwd
    set -l pwd_path (string replace -r "^$HOME" "~" $PWD)
    echo -n (set_color $cyberwave_primary)"$pwd_path"
end

function __cyberwave_venv
    if test -n "$VIRTUAL_ENV"
        set -l venv_name (basename $VIRTUAL_ENV)
        echo -n (set_color $cyberwave_comment)"("(set_color $cyberwave_tertiary)"$venv_name"(set_color $cyberwave_comment)") "
    end
end

function __cyberwave_node
    if test -f package.json
        and command -q node
        set -l node_version (node -v 2>/dev/null)
        if test -n "$node_version"
            echo -n (set_color $cyberwave_comment)"["(set_color $cyberwave_success)"$node_version"(set_color $cyberwave_comment)"] "
        end
    end
end

function __cyberwave_go
    if test -f go.mod
        and command -q go
        set -l go_version (go version | awk '{print $3}' | sed 's/go//')
        echo -n (set_color $cyberwave_comment)"["(set_color $cyberwave_secondary)"go$go_version"(set_color $cyberwave_comment)"] "
    end
end

function __cyberwave_exit_status
    set -l last_status $status
    if test $last_status -ne 0
        echo -n (set_color $cyberwave_error)"✗ $last_status "(set_color normal)
    end
end

function __cyberwave_user_host
    set -l default_user chris

    if test -n "$SSH_CONNECTION"
        echo -n (set_color $cyberwave_highlight)"$USER"(set_color $cyberwave_comment)"@"(set_color $cyberwave_quaternary)"$hostname "(set_color normal)
    else if test "$USER" != "$default_user"
        echo -n (set_color $cyberwave_warning)"$USER "(set_color normal)
    end
end

function fish_prompt
    set -l last_status $status

    # Store exit status for display
    set -g __cyberwave_last_status $last_status

    # Line 1: Status, user/host, venv, language versions, path, git
    echo -n (set_color $cyberwave_primary)"╭─"

    if test $last_status -ne 0
        echo -n (set_color $cyberwave_error)"✗ $last_status "(set_color normal)
    end

    __cyberwave_user_host
    __cyberwave_venv
    __cyberwave_go
    __cyberwave_node
    __cyberwave_pwd
    __cyberwave_git_status

    echo "" # Newline

    # Line 2: Prompt arrows
    echo -n "╰─"(set_color $cyberwave_primary)"❯"(set_color $cyberwave_secondary)"❯"(set_color $cyberwave_tertiary)"❯ "(set_color normal)
end

function fish_right_prompt
    # Timestamp on the right
    set_color $cyberwave_comment
    date "+%H:%M:%S"
    set_color normal
end
