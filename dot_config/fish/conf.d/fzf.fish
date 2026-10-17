# Enable the packaged Fish integration with its default file picker.
if command -q fzf
    fzf --fish | FZF_CTRL_R_COMMAND= FZF_ALT_C_COMMAND= source
end
