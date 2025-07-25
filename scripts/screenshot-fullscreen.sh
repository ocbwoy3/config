#!/usr/bin/env bash

# do NOT use $PATH for this!!
SS_PATH=$(timeout 30s bun run ~/config/scripts/bin/handleScreenshot.ts fullscreen)

echo "$SS_PATH"

if [[ -n "$SS_PATH" && "$SS_PATH" == /home/ocbwoy3/Pictures/Screenshots/* ]]; then
    wl-copy < "$SS_PATH"
    notify-send "Screenshot" "Fullscreen copied to clipboard!"
fi
