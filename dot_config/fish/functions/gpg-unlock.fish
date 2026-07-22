function gpg-unlock --description 'Clear stale GnuPG locks/agents (fixes "waiting for lock" signing timeouts)'
    set -l gnupg $GNUPGHOME
    test -z "$gnupg"; and set gnupg ~/.gnupg

    set_color -o $cyberpunk_secondary
    echo '  ▓▒░ gpg-unlock ░▒▓'
    set_color normal

    set_color $cyberpunk_warning
    echo '  killing gpg-agent / keyboxd / dirmngr'
    set_color normal
    gpgconf --kill all 2>/dev/null
    pkill -9 gpg-agent 2>/dev/null
    pkill -9 keyboxd 2>/dev/null
    pkill -9 dirmngr 2>/dev/null

    set -l locks $gnupg/*.lock $gnupg/public-keys.d/*.lock
    set -l removed 0
    for f in $locks
        if test -e "$f"
            rm -f "$f"; and set removed (math $removed + 1)
        end
    end
    set_color $cyberpunk_warning
    echo "  removed $removed stale lock file(s)"
    set_color normal

    set_color $cyberpunk_comment
    echo '  testing signing…'
    set_color normal
    if echo test | gpg --clearsign >/dev/null 2>&1
        set_color -o $cyberpunk_success
        echo '  ✓ signing works'
        set_color normal
        return 0
    else
        set_color -o $cyberpunk_error
        echo '  ✗ signing still failing — check GPG_TTY and your key passphrase'
        set_color normal
        return 1
    end
end
