#!/bin/bash

# cycle-layout.sh [-r] [-o [value]] [layout]
#
# Sin args:           cicla al siguiente layout
# -r:                 cicla en reversa
# layout:             salta directo a ese layout
# -o:                 cicla orientación/dirección de master/scrolling
# -o value:           salta directo a ese valor (top/left/bottom/right)
# master -o:          cambia a master y cicla orientación
# scrolling -o right: cambia a scrolling con dirección right

LAYOUTS=(dwindle master monocle scrolling)
MASTER_ORIENTATIONS=(left top right bottom center)
SCROLLING_DIRECTIONS=(right down left up)

declare -A DISPLAY_NAMES=(
    [dwindle]="Mosaico"
    [master]="Maestro"
    [monocle]="Monóculo"
    [scrolling]="Desplazamiento"
)
declare -A ORIENT_NAMES=(
    [left]="Izquierda"
    [right]="Derecha"
    [top]="Arriba"
    [bottom]="Abajo"
    [center]="Centro"
    [up]="Arriba"
    [down]="Abajo"
)

ORIENT_LAYOUTS=(master scrolling)

OUTPUT="$HOME/.config/hypr/workspace_layouts.conf"
HYPR_CONF="$HOME/.config/hypr/hyprland.conf"
touch "$OUTPUT"
if ! grep -qF "source = $OUTPUT" "$HYPR_CONF"; then
    echo "source = $OUTPUT" >> "$HYPR_CONF"
fi

REVERSE=0
ORIENT_MODE=0
TARGET_ORIENT=""
TARGET_LAYOUT=""

# --- Helpers ---

supports_orient() {
    for L in "${ORIENT_LAYOUTS[@]}"; do
        [[ "$L" == "$1" ]] && return 0
    done
    return 1
}

get_layoutopt_key() {
    case "$1" in
        master)    echo "orientation" ;;
        scrolling) echo "direction" ;;
    esac
}

get_layout_values() {
    case "$1" in
        master)    echo "${MASTER_ORIENTATIONS[@]}" ;;
        scrolling) echo "${SCROLLING_DIRECTIONS[@]}" ;;
    esac
}

apply_orient() {
    local layout="$1" value="$2"
    case "$layout" in
        master)
            hyprctl dispatch layoutmsg "orientationleft" &>/dev/null
            hyprctl dispatch layoutmsg "orientation${value}"
            ;;
        scrolling)
            hyprctl dispatch layoutmsg "direction ${value}"
            ;;
    esac
}

persist_layout() {
    local ws="$1" layout="$2"
    local line="workspace = $ws, layout:$layout"
    if grep -q "^workspace = $ws, layout:" "$OUTPUT"; then
        sed -i "s|^workspace = $ws, layout:.*|$line|" "$OUTPUT"
    else
        echo "$line" >> "$OUTPUT"
    fi
}

persist_orient() {
    local ws="$1" layout="$2" value="$3"
    local key
    key=$(get_layoutopt_key "$layout")
    local line="workspace = $ws, layoutopt:${key}:${value}"
    if grep -q "^workspace = $ws, layoutopt:${key}:" "$OUTPUT"; then
        sed -i "s|^workspace = $ws, layoutopt:${key}:.*|$line|" "$OUTPUT"
    else
        echo "$line" >> "$OUTPUT"
    fi
}

get_saved_orient() {
    local ws="$1" layout="$2"
    local key
    key=$(get_layoutopt_key "$layout")
    grep "^workspace = $ws, layoutopt:${key}:" "$OUTPUT" \
        | sed "s/.*layoutopt:${key}://" \
        | head -1
}

# --- Parseo de argumentos ---
while [[ $# -gt 0 ]]; do
    case "$1" in
        -r)
            REVERSE=1
            shift
            ;;
        -o)
            ORIENT_MODE=1
            shift
            # El valor de -o se valida más adelante cuando conocemos EFFECTIVE_LAYOUT
            # Solo guardamos provisionalmente si parece un valor (no es flag ni layout)
            if [[ -n "$1" && "$1" != -* ]]; then
                MAYBE_ORIENT="$1"
                shift
            fi
            ;;
        *)
            MATCHED=0
            for L in "${LAYOUTS[@]}"; do
                if [[ "$L" == "$1" ]]; then
                    TARGET_LAYOUT="$1"
                    MATCHED=1
                    break
                fi
            done
            if [[ $MATCHED -eq 0 ]]; then
                echo "Error: '$1' no es un layout ni flag válido. Layouts: ${LAYOUTS[*]}" >&2
                exit 1
            fi
            shift
            ;;
    esac
done

# --- Estado actual del workspace ---
read WS CURRENT_LAYOUT < <(
    hyprctl activeworkspace -j | jq -r '[.id, .tiledLayout] | @tsv'
)

# --- Modo orientación/dirección (-o) ---
if [[ $ORIENT_MODE -eq 1 ]]; then
    EFFECTIVE_LAYOUT="${TARGET_LAYOUT:-$CURRENT_LAYOUT}"

    if ! supports_orient "$EFFECTIVE_LAYOUT"; then
        echo "Error: -o solo aplica a master o scrolling (layout actual: $EFFECTIVE_LAYOUT)" >&2
        exit 1
    fi

    # Validar MAYBE_ORIENT contra los valores del layout efectivo
    if [[ -n "$MAYBE_ORIENT" ]]; then
        read -ra VALID_VALUES <<< "$(get_layout_values "$EFFECTIVE_LAYOUT")"
        for V in "${VALID_VALUES[@]}"; do
            if [[ "$V" == "$MAYBE_ORIENT" ]]; then
                TARGET_ORIENT="$MAYBE_ORIENT"
                break
            fi
        done
        if [[ -z "$TARGET_ORIENT" ]]; then
            echo "Error: '$MAYBE_ORIENT' no es válido para $EFFECTIVE_LAYOUT. Valores: $(get_layout_values "$EFFECTIVE_LAYOUT")" >&2
            exit 1
        fi
    fi

    # Cambiar layout primero si hace falta
    if [[ "$CURRENT_LAYOUT" != "$EFFECTIVE_LAYOUT" ]]; then
        hyprctl dispatch layoutmsg "setlayout $EFFECTIVE_LAYOUT"
        persist_layout "$WS" "$EFFECTIVE_LAYOUT"
        notify-send "⬡ Cambiando de Layout" \
            "${DISPLAY_NAMES[$CURRENT_LAYOUT]} → ${DISPLAY_NAMES[$EFFECTIVE_LAYOUT]}" \
            -i /usr/share/icons/Papirus/128x128/apps/pop-cosmic-workspaces.svg -u normal -t 2000
    fi

    CURRENT_ORIENT=$(get_saved_orient "$WS" "$EFFECTIVE_LAYOUT")
    [[ -z "$CURRENT_ORIENT" ]] && CURRENT_ORIENT="$(get_layout_values "$EFFECTIVE_LAYOUT" | awk '{print $1}')"

    if [[ -n "$TARGET_ORIENT" ]]; then
        NEW_ORIENT="$TARGET_ORIENT"
    else
        read -ra VALUES <<< "$(get_layout_values "$EFFECTIVE_LAYOUT")"
        for i in "${!VALUES[@]}"; do
            if [[ "${VALUES[$i]}" == "$CURRENT_ORIENT" ]]; then
                if [[ $REVERSE -eq 1 ]]; then
                    NEXT=$(( (i - 1 + ${#VALUES[@]}) % ${#VALUES[@]} ))
                else
                    NEXT=$(( (i + 1) % ${#VALUES[@]} ))
                fi
                NEW_ORIENT="${VALUES[$NEXT]}"
                break
            fi
        done
    fi

    if [[ "$CURRENT_ORIENT" == "$NEW_ORIENT" ]]; then
        notify-send "Layout ${DISPLAY_NAMES[$EFFECTIVE_LAYOUT]}" \
            "Ya es ${ORIENT_NAMES[$NEW_ORIENT]}" \
            -i /usr/share/icons/Papirus/128x128/apps/pop-cosmic-workspaces.svg -u normal -t 2000
        exit 0
    fi

    apply_orient "$EFFECTIVE_LAYOUT" "$NEW_ORIENT"
    persist_orient "$WS" "$EFFECTIVE_LAYOUT" "$NEW_ORIENT"
    sort -t '=' -k2 -n -o "$OUTPUT" "$OUTPUT"

    notify-send "⬡ ${DISPLAY_NAMES[$EFFECTIVE_LAYOUT]}" \
        "${ORIENT_NAMES[$CURRENT_ORIENT]} → ${ORIENT_NAMES[$NEW_ORIENT]}" \
        -i /usr/share/icons/Papirus/128x128/apps/pop-cosmic-workspaces.svg -u normal -t 2000
    exit 0
fi

# --- Modo layout normal ---
if [[ -n "$TARGET_LAYOUT" ]]; then
    TARGET="$TARGET_LAYOUT"
else
    for i in "${!LAYOUTS[@]}"; do
        if [[ "${LAYOUTS[$i]}" == "$CURRENT_LAYOUT" ]]; then
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

if [[ "$CURRENT_LAYOUT" == "$TARGET" ]]; then
    notify-send "Layout" "Ya estás en ${DISPLAY_NAMES[$CURRENT_LAYOUT]}" \
        -i /usr/share/icons/Papirus/128x128/apps/pop-cosmic-workspaces.svg -u normal -t 2000
    exit 0
fi

hyprctl dispatch layoutmsg "setlayout $TARGET"
persist_layout "$WS" "$TARGET"

# Restaurar layoutopt guardado si el nuevo layout lo soporta
ORIENT_SUFFIX=""
if supports_orient "$TARGET"; then
    SAVED_ORIENT=$(get_saved_orient "$WS" "$TARGET")
    if [[ -n "$SAVED_ORIENT" ]]; then
        apply_orient "$TARGET" "$SAVED_ORIENT"
        ORIENT_SUFFIX=" (${ORIENT_NAMES[$SAVED_ORIENT]})"
    fi
fi

sort -t '=' -k2 -n -o "$OUTPUT" "$OUTPUT"

notify-send "⬡ Cambiando de Layout" \
    "${DISPLAY_NAMES[$CURRENT_LAYOUT]} → ${DISPLAY_NAMES[$TARGET]}${ORIENT_SUFFIX}" \
    -i /usr/share/icons/Papirus/128x128/apps/pop-cosmic-workspaces.svg -u normal -t 2000

# Ejemplo de `workspace_layouts.conf` resultante

# workspace = 1, layout:dwindle
# workspace = 2, layout:master
# workspace = 2, layoutopt:orientation:right
# workspace = 3, layout:scrolling
# workspace = 3, layoutopt:direction:top
