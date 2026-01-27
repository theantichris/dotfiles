if test -d ~/.cargo/bin
    if not contains -- ~/.cargo/bin $PATH
        set -p PATH ~/.cargo/bin
    end
end

if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

if test -d ~/go/bin
    if not contains -- ~/go/bin $PATH
        set -p PATH ~/go/bin
    end
end

if test -d ~/.local/share/../bin
    if not contains -- ~/.local/share/../bin $PATH
        set -p PATH ~/.local/share/../bin
    end
end

if test -d /home/christopher/.npm-global/bin
    if not contains -- /home/christopher/.npm-global/bin $PATH
        set -p PATH /home/christopher/.npm-global/bin
    end
end
