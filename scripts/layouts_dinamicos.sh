#!/bin/bash
# cycle-layout.sh [-r] [layout]
LAYOUTS=(dwindle master monocle scrolling)
declare -A DISPLAY_NAMES=(
    [dwindle]="Mosaico"
    [master]="Maestro"
    [monocle]="Monóculo"
    [scrolling]="Desplazamiento"
)
OUTPUT="$HOME/.config/hypr/workspace_layouts.conf"
HYPR_CONF="$HOME/.config/hypr/hyprland.conf"
touch "$OUTPUT"
if ! grep -qF "source = $OUTPUT" "$HYPR_CONF"; then
    echo "source = $OUTPUT" >> "$HYPR_CONF"
fi
REVERSE=0
if [[ "$1" == "-r" ]]; then
    REVERSE=1
    shift
fi
read WS CURRENT < <(
    hyprctl activeworkspace -j | jq -r '[.id, .tiledLayout] | @tsv'
)
if [[ -n "$1" ]]; then
    VALID=0
    for L in "${LAYOUTS[@]}"; do
        if [[ "$L" == "$1" ]]; then
            VALID=1
            break
        fi
    done
    if [[ $VALID -eq 0 ]]; then
        echo "Error: layout '$1' no válido. Opciones: ${LAYOUTS[*]}" >&2
        exit 1
    fi
    TARGET="$1"
else
    for i in "${!LAYOUTS[@]}"; do
        if [[ "${LAYOUTS[$i]}" == "$CURRENT" ]]; then
            if [[ $REVERSE -eq 1 ]]; then
                NEXT=$(( (i - 1 + ${#LAYOUTS[@]}) % ${#LAYOUTS[@]} ))
            else
                NEXT=$(( (i + 1) % ${#LAYOUTS[@]} ))
            fi
            TARGET="${LAYOUTS[$NEXT]}"
            break
        fi
    done
fi
if [[ "$CURRENT" == "$TARGET" ]]; then
    notify-send "Layout" "Ya estás en ${DISPLAY_NAMES[$CURRENT]}" \
        -i /usr/share/icons/Papirus/128x128/apps/pop-cosmic-workspaces.svg -u normal -t 2000
    exit 0
fi
hyprctl dispatch layoutmsg "setlayout $TARGET"
notify-send "⬡ Cambiando de Layout" "De ${DISPLAY_NAMES[$CURRENT]} a ${DISPLAY_NAMES[$TARGET]}" \
    -i /usr/share/icons/Papirus/128x128/apps/pop-cosmic-workspaces.svg -u normal -t 2000
LINE="workspace = $WS, layout:$TARGET"
if grep -q "^workspace = $WS," "$OUTPUT"; then
    sed -i "s|^workspace = $WS,.*|$LINE|" "$OUTPUT"
else
    echo "$LINE" >> "$OUTPUT"
fi
sort -t '=' -k2 -n -o "$OUTPUT" "$OUTPUT"
