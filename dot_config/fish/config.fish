# Show Fastfetch instead of Fish's built-in welcome message.
function fish_greeting
    if command -q fastfetch
        fastfetch
    end
end

# Override CachyOS's grep alias after its startup configuration loads.
if command -q rg
    alias grep='rg'
end
