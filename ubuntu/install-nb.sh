#!/usr/bin/env bash
# Install nb on Ubuntu/WSL (no initialization)
# Usage: bash install-nb.sh

set -euo pipefail

# --- Prereqs ---
sudo apt update
sudo apt install -y git curl

# --- Install nb binary ---
NB_URL="https://raw.githubusercontent.com/xwmx/nb/master/nb"
sudo curl -fsSL "$NB_URL" -o /usr/local/bin/nb
sudo chmod +x /usr/local/bin/nb

# --- Shell completions ---
# Installs completions for bash/zsh/fish where supported
sudo nb completions install || true

# --- Optional: install helpful tools nb can use (bat, ripgrep, pandoc, fzf) ---
# Uncomment if you want these now:
# sudo apt install -y bat ripgrep pandoc fzf

# --- Verify ---
echo "nb installed at: $(command -v nb)"
nb --version || true
