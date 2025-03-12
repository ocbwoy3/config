KBLANG=$(hyprctl getoption input:kb_layout | awk 'NR==1{print $2}')
if [ "$KBLANG" = "us" ] ; then
    hyprctl --batch "\
        keyword input:kb_layout lv;\
        keyword input:kb_variant apostrophe;"
        # keyword input:kb_options compose:apostrophe;"
    notify-send -u low "OCbwoy3's Dotfiles" "Keyboard Layout: Latvian"
    exit
elif [ "$KBLANG" = "lv" ] ; then
    # hyprctl --batch "\
    #     keyword input:kb_layout us;\
    #     keyword input:kb_variant;"
    # i have no fucking idea how to unset input:kb_variant with hyprctl
    hyprctl reload
    notify-send -u low "OCbwoy3's Dotfiles" "Keyboard Layout: English"
    exit
fi