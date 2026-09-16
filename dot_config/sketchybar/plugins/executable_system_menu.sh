#!/bin/bash

close_menu() {
  sketchybar --set system popup.drawing=off >/dev/null 2>&1 || true
}

case "$1" in
  settings)
    close_menu
    open -b com.apple.systempreferences
    ;;
  lock)
    close_menu
    osascript -e 'tell application "System Events" to key code 12 using {control down, command down}' >/dev/null 2>&1
    ;;
  sleep)
    close_menu
    osascript -e 'tell application "System Events" to sleep' >/dev/null 2>&1
    ;;
  logout)
    close_menu
    osascript <<'APPLESCRIPT'
set answer to button returned of (display dialog "Log out of this Mac?" buttons {"Cancel", "Log Out"} default button "Log Out" with icon caution)
if answer is "Log Out" then tell application "System Events" to log out
APPLESCRIPT
    ;;
  restart)
    close_menu
    osascript <<'APPLESCRIPT'
set answer to button returned of (display dialog "Restart this Mac?" buttons {"Cancel", "Restart"} default button "Restart" with icon caution)
if answer is "Restart" then tell application "System Events" to restart
APPLESCRIPT
    ;;
  shutdown)
    close_menu
    osascript <<'APPLESCRIPT'
set answer to button returned of (display dialog "Shut down this Mac?" buttons {"Cancel", "Shut Down"} default button "Shut Down" with icon caution)
if answer is "Shut Down" then tell application "System Events" to shut down
APPLESCRIPT
    ;;
esac
