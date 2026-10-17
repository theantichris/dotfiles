# Load Fish's packaged Linecast completions once, including shortcut commands.
# Trigger autoload here so weather/moon work before the first linecast completion.
if command -q linecast
    complete -C 'linecast ' >/dev/null
end
