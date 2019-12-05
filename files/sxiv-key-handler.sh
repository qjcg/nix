#!/bin/sh

# Called by sxiv(1) after the external prefix key (C-x by default) is pressed.
# The next key combo is passed as its first argument. Passed via stdin are the
# images to act upon, one path per line: all marked images, if in thumbnail
# mode and at least one image has been marked, otherwise the current image.
# sxiv(1) blocks until this script terminates. It then checks which images
# have been modified and reloads them.

# The key combo argument has the following form: "[C-][M-][S-]KEY",
# where C/M/S indicate Ctrl/Meta(Alt)/Shift modifier states and KEY is the X
# keysym as listed in /usr/include/X11/keysymdef.h without the "XK_" prefix.

case "$1" in
"f") while read file; do feh --bg-fill "$file" & done ;;
"F") while read file; do feh --bg-fill --no-xinerama "$file" & done ;;
"m") while read file; do feh --bg-max "$file" & done ;;
"M") while read file; do feh --bg-max --no-xinerama "$file" & done ;;
esac
