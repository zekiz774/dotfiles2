#!/usr/bin/env bash
#
# Screenshot utility
# Dependencies: grim, slurp, wl-clipboard, pw-play, libnotify
#

shutter_sound="/usr/share/sounds/freedesktop/stereo/camera-shutter.oga"
output_dir="$HOME/Pictures/screenshots"
file="$output_dir/screenshot-$(date +'%Y%m%d-%H%M%S').png"

mkdir -p "$output_dir"

if [ "$1" = "--region" ]; then
  selection=$(slurp)
  if [ $? -ne 0 ] || [ -z "$selection" ]; then
    notify-send "Screenshot cancelled"
    exit 1
  fi

  pw-play "$shutter_sound"
  grim -c -g "$selection" "$file"
else
  active_output=$(hyprctl -j activeworkspace | jq -r '.monitor')

  pw-play "$shutter_sound"
  grim -c -o "$active_output" "$file"
fi

wl-copy <"$file"
notify-send "Screenshot saved" "$file"
