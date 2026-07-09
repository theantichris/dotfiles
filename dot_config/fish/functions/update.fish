function sys-update
    cachy-update
    shelly upgrade-all
    go-global-update
    cargo install-update -a
end
