# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

# Override CachyOS's grep alias after its startup configuration loads.
if command -q rg
    alias grep='rg'
end
