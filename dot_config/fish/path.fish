if test -d ~/go/bin
    if not contains -- ~/go/bin $PATH
        set -p PATH ~/go/bin
    end
end

if test -d ~/.cargo/bin
    if not contains -- ~/.cargo/bin $PATH
        set -p PATH ~/.cargo/bin
    end
end

set -p PATH ~/.local/bin
