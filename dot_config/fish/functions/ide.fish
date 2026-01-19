function ide --description "Open IDE-style pane layout"
    # Split right pane (30% width)
    wezterm cli split-pane --right --percent 30
    # Move back to left pane
    wezterm cli activate-pane-direction left
    # Split bottom pane (15% height)
    wezterm cli split-pane --bottom --percent 15
    # Focus top-left (main editing area)
    wezterm cli activate-pane-direction up
end
