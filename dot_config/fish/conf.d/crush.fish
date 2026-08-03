# Crush launchers

# `ai` — general assistant (Gemini-on-the-web style) in the notes workspace.
# Runs Crush with its cwd pinned to the notes repo so general chat never
# scatters CRUSH.md files into code repos. Extra args pass through to crush.
function ai --description 'Crush general assistant in the notes workspace'
    crush --cwd ~/.local/share/clin/notes $argv
end
