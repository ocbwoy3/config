KBLANG=$(hyprctl getoption input:kb_layout | awk 'NR==1{print $2}')

# hyprctl switchxkblayout semico--usb-gaming-keyboard- next

hyprctl switchxkblayout current next
notify-send -u low "Keyboard" "Language changed"
