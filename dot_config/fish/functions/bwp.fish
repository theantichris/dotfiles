function bwp --description 'Fuzzy-pick a Bitwarden login and copy its password'
    set -l vault_status (bw status | jq -r '.status')
    or return 1

    switch $vault_status
        case unauthenticated
            set -gx BW_SESSION (bw login --raw)
            or return 1
        case locked
            set -gx BW_SESSION (bw unlock --raw)
            or return 1
        case unlocked
        case '*'
            printf 'Unknown Bitwarden status: %s\n' "$vault_status" >&2
            return 1
    end

    set -l query (string join ' ' $argv)
    set -l selected (
        bw list items |
            jq -r '.[] | select(.type == 1) | [.id, .name, (.login.username // "")] | @tsv' |
            fzf --delimiter='\t' --with-nth=2,3 --prompt='Bitwarden> ' --query="$query"
    )
    or return 1

    test -n "$selected"; or return 0

    set -l parts (string split \t -- "$selected")
    set -l id $parts[1]
    set -l name $parts[2]

    bw get password "$id" | wl-copy
    or return 1

    printf 'Copied password for %s.\n' "$name"
end
