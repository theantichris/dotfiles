#!/usr/bin/env bash
set -euo pipefail

LIST="${1:-"$(dirname "$0")/apt-packages.txt"}"

[ -f "$LIST" ] || { echo "Missing $LIST" >&2; exit 1; }
sudo apt-get update -y

# Install only if list is non-empty
if [ -s "$LIST" ]; then
  sudo xargs -a "$LIST" -r apt-get install -y
else
  echo "No packages to install."
fi
