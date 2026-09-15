#!/bin/bash

if [ -n "$INFO" ]; then
  sketchybar --set "$NAME" label="$INFO"
fi
