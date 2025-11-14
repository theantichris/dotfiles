if test -f ~/.cargo/bin
    if not contains -- ~/.cargo/bin $PATH
        set -p PATH ~/.cargo/bin
    end
end

if test -f ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

if test -d ~/go/bin
    if not contains -- ~/go/bin $PATH
        set -p PATH ~/go/bin
    end
end
