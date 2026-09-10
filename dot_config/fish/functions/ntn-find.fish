function ntn-find --description 'Search Notion pages by title and render the selected page in Glow'
    set -l query (string join ' ' $argv)

    if test -z "$query"
        read -P 'Notion search> ' query
        or return 1
    end

    test -n "$query"; or return 0

    set -l results (
        ntn api /v1/search query="$query" page_size:=100 |
            jq -r '.results[] |
                select(.object == "page") |
                [.id, (first(.properties[] | select(.type == "title") | .title | map(.plain_text) | join("")) // "(untitled)")] |
                @tsv'
    )
    or return 1

    if test (count $results) -eq 0
        printf 'No matching Notion pages found.\n'
        return 0
    end

    set -l selected (
        printf '%s\n' $results |
            fzf --delimiter='\t' --with-nth=2 --prompt='Notion> ' --query="$query"
    )
    or return 1

    test -n "$selected"; or return 0

    set -l id (string split \t -- "$selected")[1]
    ntn pages get "$id" | glow
end
