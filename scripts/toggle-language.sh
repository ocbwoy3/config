KBLANG=$(hyprctl getoption input:kb_layout | awk 'NR==1{print $2}')
if [ "$KBLANG" = "us" ] ; then
	hyprctl --batch "\
		keyword input:kb_layout lv;\
		keyword input:kb_variant apostrophe;"
		# keyword input:kb_options compose:apostrophe;"
	notify-send -u low "Tastatūra" "🇱🇻 Valoda: Latviešu"
	exit
elif [ "$KBLANG" = "lv" ] ; then
	hyprctl --batch "\
		keyword input:kb_layout us;\
		keyword input:kb_variant \"\";"
		# keyword input:kb_options compose:apostrophe;"
	notify-send -u low "Tastatūra" "🇺🇸 Valoda: Angļu"
	exit
fi
