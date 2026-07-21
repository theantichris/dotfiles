# Prefer modern replacements when available, fall back to the originals.

if command -q rg
    alias grep='rg'
end

if command -q fd
    alias find='fd'
else if command -q fdfind # Debian/Ubuntu package name
    alias find='fdfind'
    alias fd='fdfind'
end
