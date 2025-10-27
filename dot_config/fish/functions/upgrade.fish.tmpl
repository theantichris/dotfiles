function upgrade --description 'System + dev tool upgrades (paru/pacman, npm -g, go-global-update, uv tools)'
    # System packages (prefer paru if available, otherwise pacman)
    if type -q paru
        paru -Syu
    else if type -q pacman
        sudo pacman -Syu
    end

    # Go modules/tools (your existing script)
    if type -q go-global-update
        and go-global-update
    end

    # Node global packages
    if type -q npm
        and npm -g update
    end

    # Python standalone tools managed by uv (pipx replacement)
    if type -q uv
        and uv tool upgrade --all
    end
end
