function ghpm --description 'Move a GitHub Project item to a given status'
    if test (count $argv) -lt 2
        echo "Usage: ghpm <item_id> <Status>"
        echo "Valid: Backlog | Ready | In progress | In review | Done"
        return 1
    end

    set -l item_id $argv[1]
    set -l status_name "$argv[2]"

    set -l project_id PVT_kwHOABaups4BDqWe
    set -l field_id PVTSSF_lAHOABaups4BDqWezg1g6b0

    set -l status_id
    switch $status_name
        case Backlog
            set status_id f75ad846
        case Ready
            set status_id 61e4505c
        case 'In progress'
            set status_id 47fc9ee4
        case 'In review'
            set status_id df73e18b
        case Done
            set status_id 98236657
        case '*'
            echo "❌ Unknown status: $status_name"
            echo "Valid options: Backlog, Ready, In progress, In review, Done"
            return 1
    end

    echo "→ Moving item $item_id to '$status_name'..."
    gh project item-edit --id $item_id --project-id $project_id --field-id $field_id --single-select-option-id $status_id
end
