# Go
if command -q go
    fish_add_path --path (go env GOPATH)/bin
end

# Rust / Cargo
fish_add_path --path $HOME/.cargo/bin

# User-installed executables
fish_add_path --path $HOME/.local/bin
