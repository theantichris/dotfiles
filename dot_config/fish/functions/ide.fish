function ide --description "Open IDE-style pane layout" --argument project
    # Set working directory based on project argument
    if test -n "$project"
        # Project aliases
        switch $project
            case tac
                set project theantichris.com
        end
        set project_dir ~/Code/$project
        if not test -d $project_dir
            echo "Project directory not found: $project_dir"
            return 1
        end
        set cwd_flag --cwd $project_dir
    else
        set cwd_flag
    end

    # Split right pane (30% width) - runs claude if project specified
    if test -n "$project"
        wezterm cli split-pane --right --percent 30 $cwd_flag -- claude
    else
        wezterm cli split-pane --right --percent 30
    end

    # Move back to left pane
    wezterm cli activate-pane-direction left

    # Split bottom pane (15% height) and capture its pane ID
    set bottom_pane_id (wezterm cli split-pane --bottom --percent 15 $cwd_flag)

    # Split bottom pane horizontally - right side runs project-specific command
    if test -n "$project"
        switch $project
            case tac theantichris.com
                set bottom_cmd hugo serve -D
            case '*'
                set bottom_cmd fish -c gotw
        end
        wezterm cli split-pane --right --percent 50 --pane-id $bottom_pane_id $cwd_flag -- $bottom_cmd
    else
        wezterm cli split-pane --right --percent 50 --pane-id $bottom_pane_id
    end

    # Focus top-left (main editing area)
    wezterm cli activate-pane-direction up

    # Run helix in main pane if project specified
    if test -n "$project"
        cd $project_dir
        hx .
    end
end
