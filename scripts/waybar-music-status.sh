#!/bin/bash

function _sanitize {
	sed -r "s/(^[ ]*)|([ ]*$)//g" | sed -r 's/\&/\&amp;/g' | sed -r 's/\"/\&quot;/g' | sed -r "s/'/\&apos;/g"
}

# {{artist}} — {{title}}

SONGNAME="$( playerctl -s -p cider,OCbwoy3_s_iPhone metadata -f "{{artist}} — {{title}}" | _sanitize )"
ALBUMNAME="$( playerctl -s -p cider,OCbwoy3_s_iPhone metadata album | _sanitize )"

if [ ${#SONGNAME} -gt 0 ] ; then
		printf "{\"text\": \"  $SONGNAME\", \"tooltip\": \"$ALBUMNAME\", \"class\":\"music\" }"
else
	printf "{\"text\": \"\", \"tooltip\": \" \", \"class\":\"invisible\" }"
fi
