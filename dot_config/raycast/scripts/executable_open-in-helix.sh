#!/usr/bin/env bash
# @raycast.schemaVersion 1
# @raycast.title Open Project In Helix (kitty)
# @raycast.packageName Dev
# @raycast.mode silent
# @racasy.argument1 { "type": "text", "placeholder": "Path to project (e.g. ~/Projects/foo)" }

PROJECT_PATH="$1"

kitty --directory "$PROJECT_PATH" hx .
