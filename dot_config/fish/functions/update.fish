function update --description 'Update system and development tools'
    shelly; or return

    if command -q go-global-update
        go-global-update; or return
    end

    if command -q cargo
        cargo install-update -a; or return
    end

    if command -q gh
        gh extension upgrade --all; or return
    end
end
