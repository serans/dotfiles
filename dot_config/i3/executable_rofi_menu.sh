#!/bin/bash


# Show options in a transparent terminal overlay
menu="
a) layout: split (default)
s) layout: stack
d) layout: tabs
f) fullscreen toggle
h) split: horizontal
v) split: vertical
space) toggle floating window
n) display: move to left
m) display: move to right
"

echo -e "$menu" | \
  rofi -dmenu -theme Monokai -no-custom -format 'i' -p "Layout" \
  -kb-custom-1 "a" \
  -kb-custom-2 "s" \
  -kb-custom-3 "d" \
  -kb-custom-4 "f" \
  -kb-custom-5 "h" \
  -kb-custom-6 "v" \
  -kb-custom-7 "space" \
  -kb-custom-8 "n" \
  -kb-custom-9 "m" \

exit_code=$?

case $exit_code in
  10) i3-msg layout toggle split ;;
  11) i3-msg layout stack;;
  12) i3-msg layout tabs;;
  13) i3-msg fullscreen toggle ;;
  14) i3-msg split h ;;
  15) i3-msg split v ;;
  16) i3-msg floating toggle ;;
  17) i3-msg move workspace to output left ;;
  18) i3-msg move workspace to output right ;;
  *) echo "Exit code: $exit_code" ;;
esac
