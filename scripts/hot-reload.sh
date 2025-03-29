#!/bin/bash

pkill -9 waybar

hyprctl dispatch exec "GTK_THEME=Adwaita waybar -c ~/config/config/waybar/config -s ~/config/config/waybar/style.css" &
hyprctl reload

ROBLOX_PID="$(pidof sober)"

echo ${#ROBLOX_PID}

if [ ${#ROBLOX_PID} -lt 1 ]; then
	rm /tmp/.regretevator_state
fi
