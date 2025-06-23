# run roblox in fullscreen with mouse sensitivity of the os default and not some value set by roblox

#!/usr/bin/env sh
HYPRGAMEMODE=$(pidof waybar | awk 'NR>=1{print 1}') # $(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = 1 ] ; then
   # hyprctl --batch "\
   #     keyword animations:enabled 0;\
   #     keyword decoration:drop_shadow 0;\
   #     keyword decoration:blur:enabled 0;\
   #     keyword general:gaps_in 0;\
   #     keyword general:gaps_out 0;\
   #     keyword general:border_size 0;\
   #     keyword decoration:rounding 0;\
   #		keyword decoration:active_opacity 1;\
   #		keyword decoration:inactive_opacity 1;\
   #		keyword decoration:fullscreen_opacity 1;"
    pkill -9 waybar
    exit
fi
bash ~/config/scripts/hot-reload.sh
# hyprctl reload
