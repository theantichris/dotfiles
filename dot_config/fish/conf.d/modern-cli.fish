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

# Termux/macOS ship helix as `hx`; Arch names the binary `helix`.
if not command -q helix; and command -q hx
    alias helix='hx'
end
