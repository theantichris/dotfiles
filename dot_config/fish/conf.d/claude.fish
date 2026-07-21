set -l claude_cli $PREFIX/lib/node_modules/@anthropic-ai/claude-code/cli.js
if test -f $claude_cli
    alias claude "node $claude_cli"
end
