function update
    go-global-update
    cargo install-update -a
    cachy-update
    shelly upgrade-all
end
