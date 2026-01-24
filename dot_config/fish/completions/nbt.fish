function __nbt_templates
    for f in ~/.nb/home/templates/*.md
        basename $f .md
    end
end

complete -c nbt -f -n "__fish_use_subcommand" -a "(__nbt_templates)" -d "Template"
