#!/bin/bash

# pin-tiled_hyprland.sh {toggle|goto <workspace>}

case "$1" in
    toggle)
        hyprctl dispatch tagwindow sticky  # toggle nativo
        ;;
    goto)
        [[ -z "$2" ]] && { echo "Uso: $0 goto <workspace>"; exit 1; }

        # Mover todas las ventanas sticky al workspace destino
        hyprctl clients -j | jq -r '.[] | select(.tags[] == "pinTiled") | .address' | \
        while read -r addr; do
            hyprctl dispatch movetoworkspacesilent "$2,address:$addr"
        done

        # Ir al workspace
        hyprctl dispatch workspace "$2"
        ;;
    *)
        echo "Uso: $0 {toggle|goto <workspace>}"
        exit 1
        ;;
esac
