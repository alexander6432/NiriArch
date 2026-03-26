#!/bin/bash

layout=$(hyprctl activeworkspace -j | jq -r '.tiledLayout')

case "$layout" in
"dwindle")
  echo "Mosaico"
  ;;
"master")
  echo "Maestro"
  ;;
"monocle")
  echo "Monóculo"
  ;;
"scrolling")
  echo "Desplazamiento"
  ;;
*)
  echo ""
  ;;
esac
