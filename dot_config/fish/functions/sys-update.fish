function sys-update
    cachy-update
    shelly upgrade-all
    go-global-update
    cargo install-update -a
    gh extension upgrade --all
end
