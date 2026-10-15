# Use bat for syntax-highlighted man pages.
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
