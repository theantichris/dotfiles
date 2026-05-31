function wowbu --description 'Back up WoW WTF and Interface folders to the Seafile Vault as zip archives'
    set --local src "$HOME/Faugus/battlenet/drive_c/Program Files (x86)/World of Warcraft/_retail_"
    set --local dest "$HOME/Seafile/Vault/WOW"

    # Don't wipe the backup unless the source folders are actually present
    if not test -d "$src/WTF"; or not test -d "$src/Interface"
        echo "wowbu: WoW source folders not found in '$src'" >&2
        return 1
    end

    echo "wowbu: clearing $dest ..."
    rm -rf "$dest"
    mkdir -p "$dest"

    pushd "$src" >/dev/null

    echo "wowbu: compressing WTF ..."
    zip -r -q "$dest/WTF.zip" WTF

    echo "wowbu: compressing Interface ..."
    zip -r -q "$dest/Interface.zip" Interface

    popd >/dev/null

    echo "wowbu: backup complete -> $dest"
end
