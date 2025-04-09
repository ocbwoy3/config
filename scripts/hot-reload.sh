#!/bin/bash

pkill -9 waybar > /dev/null

hyprctl dispatch exec "GTK_THEME=Adwaita waybar -c ~/config/config/waybar/config -s ~/config/config/waybar/style.css" > /dev/null &
hyprctl reload > /dev/null &

ROBLOX_PID="$(pidof sober)"

# echo ${#ROBLOX_PID}

if [ ${#ROBLOX_PID} -lt 1 ]; then
	trap "rm /tmp/.regretevator_state" EXIT > /dev/null
fi
