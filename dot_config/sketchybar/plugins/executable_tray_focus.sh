#!/bin/bash

app="$1"
[ -z "$app" ] && exit 0

open -a "$app" >/dev/null 2>&1 || true
