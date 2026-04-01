#!/bin/bash

# get_layout.sh [l] [d]

# l:           layout como icono
# d:           direction/orientation como icono

SOURCE="$HOME/.config/hypr/workspace_layouts.conf"

read WS LAYOUT < <(hyprctl activeworkspace -j | jq -r '[.id, .tiledLayout] | @tsv')

# Leer orientación/dirección según el layout activo
if [[ $LAYOUT == "master" ]]; then
    RESULTADO=$(grep "^workspace = $WS, layoutopt:orientation:" "$SOURCE" | awk -F: '{print $NF}')
elif [[ $LAYOUT == "scrolling" ]]; then
    RESULTADO=$(grep "^workspace = $WS, layoutopt:direction:" "$SOURCE" | awk -F: '{print $NF}')
fi

# Detectar flags (admite cualquier orden y combinación)
LAYOUT_ICON=0
ORIENT_ICON=0
for arg in "$@"; do
    case "$arg" in
        l) LAYOUT_ICON=1 ;;
        d) ORIENT_ICON=1 ;;
    esac
done

# Traducir layout
if [[ $LAYOUT_ICON -eq 1 ]]; then
    case "$LAYOUT" in
        dwindle)  LAYOUT_OUT="" ;;
        master)   LAYOUT_OUT="" ;;
        monocle)  LAYOUT_OUT="" ;;
        scrolling) LAYOUT_OUT="󰏞" ;;
        *)        LAYOUT_OUT="" ;;
    esac
else
    case "$LAYOUT" in
        dwindle)  LAYOUT_OUT="Mosaico" ;;
        master)   LAYOUT_OUT="Maestro" ;;
        monocle)  LAYOUT_OUT="Monóculo" ;;
        scrolling) LAYOUT_OUT="Desplazamiento" ;;
        *)        LAYOUT_OUT="Desconocido" ;;
    esac
fi

# Traducir orientación/dirección
if [[ $ORIENT_ICON -eq 1 ]]; then
    case "$RESULTADO" in
        left)   ORIENT_OUT="" ;;
        right)  ORIENT_OUT="" ;;
        top)    ORIENT_OUT="" ;;
        bottom) ORIENT_OUT="" ;;
        up)     ORIENT_OUT="" ;;
        down)   ORIENT_OUT="" ;;
        center) ORIENT_OUT="" ;;
        *)      ORIENT_OUT="" ;;
    esac
else
    case "$RESULTADO" in
        left)   ORIENT_OUT="Izquierda" ;;
        right)  ORIENT_OUT="Derecha" ;;
        top)    ORIENT_OUT="Arriba" ;;
        bottom) ORIENT_OUT="Abajo" ;;
        up)     ORIENT_OUT="Arriba" ;;
        down)   ORIENT_OUT="Abajo" ;;
        center) ORIENT_OUT="Centro" ;;
        *)      ORIENT_OUT="" ;;
    esac
fi

echo "${LAYOUT_OUT}${ORIENT_OUT:+ $ORIENT_OUT}"
