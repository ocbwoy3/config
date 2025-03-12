#!/bin/bash

sleep 1

# kill all possible running xdg-desktop-portals
kill -9 $(pidof xdg-desktop-portal-hyprland)
kill -9 $(pidof xdg-desktop-portal-gnome)
kill -9 $(pidof xdg-desktop-portal-kde)
kill -9 $(pidof xdg-desktop-portal-lxqt)
kill -9 $(pidof xdg-desktop-portal-wlr)
kill -9 $(pidof xdg-desktop-portal-gtk)
kill -9 $(pidof xdg-desktop-portal)
sleep 1

# start xdg-desktop-portal-hyprland
/usr/lib/xdg-desktop-portal-hyprland &
sleep 2

# start xdg-desktop-portal
/usr/lib/xdg-desktop-portal &
sleep 1
