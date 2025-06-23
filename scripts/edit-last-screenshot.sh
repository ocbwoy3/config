#!/bin/bash

SCREENSHOTS_DIR="$HOME/Pictures/Screenshots"

LAST_SCREENSHOT=$(ls -t "$SCREENSHOTS_DIR" | head -n 1)

if [[ -n "$LAST_SCREENSHOT" ]]; then
    swappy -f "$SCREENSHOTS_DIR/$LAST_SCREENSHOT" -o "$SCREENSHOTS_DIR/$LAST_SCREENSHOT"
else
    notify-send -u critical -t 3 "Kļūda" "Nevar atrast failu!"
fi
