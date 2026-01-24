function nbt --description "Create nb note from template"
    if test (count $argv) -eq 0
        echo "Usage: nbt <template> [nb add options...]"
        echo "Templates: "(ls ~/.nb/home/templates/*.md | xargs -n1 basename | sed 's/\.md$//' | tr '\n' ' ')
        return 1
    end

    set template_name $argv[1]
    set template_path ~/.nb/home/templates/$template_name.md

    if not test -f $template_path
        echo "Template not found: $template_name"
        return 1
    end

    nb add --template $template_path $argv[2..]
end
