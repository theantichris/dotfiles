# Syntax-highlighted file previews with bat.
if command -q fzf; and command -q bat; and command -q eza
    set -gx FZF_CTRL_T_OPTS '--preview "if [ -d {} ]; then eza --tree --level=2 --color=always {}; else bat --style=numbers --color=always --line-range :300 {}; fi" --preview-window=right,60%,wrap'

    fzf --fish | FZF_CTRL_R_COMMAND= FZF_ALT_C_COMMAND= source
end
