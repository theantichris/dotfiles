function update
    pacman -Syu
    shelly upgrade-all
    go-global-update
    cargo install-update -a
end
