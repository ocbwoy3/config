#!/usr/bin/env bash

GAMES=$(cat ~/config/scripts/lib/games.txt)

SELECTED=$(echo "$GAMES" | cut -d'%' -f1 | wofi --show dmenu -p "Play Roblox...")

if [ -n "$SELECTED" ]; then
	PLACE_ID=$(echo "$GAMES" | grep "^$SELECTED" | sed 's/.*%%% //')
	if [ -n "$PLACE_ID" ]; then
		exec $PLACE_ID
	fi
fi
