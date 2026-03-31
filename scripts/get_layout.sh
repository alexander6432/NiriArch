#!/bin/bash

layout=$(hyprctl activeworkspace -j | jq -r '.tiledLayout')

if [[ $1 != "i" ]]; then
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
    echo "No Entiendo"
    ;;
  esac
else
  case "$layout" in
  "dwindle")
    echo ""
    ;;
  "master")
    echo "󱂬"
    ;;
  "monocle")
    echo ""
    ;;
  "scrolling")
    echo "󰡎"
    ;;
  *)
    echo ""
    ;;
  esac
fi
