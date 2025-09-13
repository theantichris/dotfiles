#!/usr/bin/env bash
set -euo pipefail

OUT="${1:-"$(dirname "$0")/apt-packages.txt"}"

# Collect "Install:" entries from apt history (current + rotated gz logs)
{
  sudo grep  -h '^Install: ' /var/log/apt/history.log        2>/dev/null || true
  sudo zgrep -h '^Install: ' /var/log/apt/history.log*.gz    2>/dev/null || true
} \
| sed 's/, /\n/g' \
| sed -E 's/^\s+//; s/\s+$//' \
| sed -E 's/^Install: //' \
| grep -vi 'automatic' \
| awk -F':' '{print $1}' \
| sed -E 's/^\s+//; s/\s+$//' \
| grep -v '^$' \
| sort -u > "$OUT"

echo "Exported to $OUT"
