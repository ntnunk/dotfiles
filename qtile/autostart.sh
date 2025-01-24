#!/usr/bin/bash

function run {
  if ! pgrep $1;
  then
    $@&
  fi
}
# Stop the screen from blanking every 10 minutes
xset -dpms
xset s 0 0
xset s off

run xrandr --output HDMI-0 --left-of DVI-D-0
run sleep 5
run picom --experimental-backends --config $HOME/.config/qtile/picom.conf &
run feh --bg-scale ~/Pictures/Wallpapers/a_music_stand_with_a_book_on_it.jpg
run flameshot
#run pavucontrol

