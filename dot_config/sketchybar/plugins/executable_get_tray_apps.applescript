#!/usr/bin/osascript

-- Return apps that expose a secondary menu bar (menu bar 2), one per line.
-- Include the bundle id when System Events exposes it so SketchyBar can
-- render the app's native icon more reliably than by name alone.
tell application "System Events"
    set trayApps to {}

    repeat with proc in every process
        try
            if exists menu bar 2 of proc then
                set appName to (name of proc) as text
                set bundleID to ""

                try
                    set bundleID to (bundle identifier of proc) as text
                end try

                set end of trayApps to appName & tab & bundleID
            end if
        end try
    end repeat
end tell

set AppleScript's text item delimiters to linefeed
return trayApps as text
