#!/usr/bin/bash

function run {
  if ! pgrep $1;
  then
    $@&
  fi
}
# Stop the screen from blanking every 10 minutes
run xset -dpms
run xset s 0 0
run xset s off
run setxkbmap -option caps:escape


run xrandr --output HDMI-0 --left-of DVI-D-0
run sleep 5
run picom --experimental-backends --config $HOME/.config/qtile/picom.conf &
run feh --bg-scale ~/Pictures/nord-wallpaper-01.webp
run nm-applet
run flameshot
#run pavucontrol

