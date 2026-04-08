#!/bin/bash

layout=$(hyprctl activeworkspace -j | jq -r '.tiledLayout')

case "$layout" in
"monocle")
  hyprctl dispatch togglefloating
  ;;
"scrolling")
  hyprctl dispatch layoutmsg fit active
  ;;
*)
  hyprctl dispatch fullscreen 1
  ;;
esac
