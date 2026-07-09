function update
    cachy-update < /dev/null
    shelly upgrade-all
    go-global-update
    cargo install-update -a
end
