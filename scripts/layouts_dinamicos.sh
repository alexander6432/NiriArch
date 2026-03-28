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

# ─── Ejemplo de workspace_layouts.conf resultante ─────────────────────────────
#
# workspace = 1, layout:dwindle
# workspace = 2, layout:master
# workspace = 2, layoutopt:orientation:right
# workspace = 3, layout:scrolling
# workspace = 3, layoutopt:direction:top

# ─── Layouts disponibles y sus opciones ───────────────────────────────────────

# Orden de ciclo de layouts
LAYOUTS=(dwindle master monocle scrolling)

# Valores válidos de orientación para el layout master
MASTER_ORIENTATIONS=(left top right bottom center)

# Valores válidos de dirección para el layout scrolling
SCROLLING_DIRECTIONS=(right down left up)

# Nombres para mostrar en notificaciones (layouts)
declare -A DISPLAY_NAMES=(
    [dwindle]="Mosaico"
    [master]="Maestro"
    [monocle]="Monóculo"
    [scrolling]="Desplazamiento"
)

# Nombres para mostrar en notificaciones (orientaciones y direcciones)
declare -A ORIENT_NAMES=(
    [left]="Izquierda"
    [right]="Derecha"
    [top]="Arriba"
    [bottom]="Abajo"
    [center]="Centro"
    [up]="Arriba"
    [down]="Abajo"
)

# Layouts que soportan orientación/dirección
ORIENT_LAYOUTS=(master scrolling)

# ─── Archivos de configuración ─────────────────────────────────────────────────

# Archivo donde se persisten los layouts y layoutopts por workspace
OUTPUT="$HOME/.config/hypr/workspace_layouts.conf"

# Archivo principal de Hyprland; se le agrega el source si aún no existe
HYPR_CONF="$HOME/.config/hypr/hyprland.conf"

# Crear el archivo de layouts si no existe
touch "$OUTPUT"

# Inyectar el source en hyprland.conf una sola vez
if ! grep -qF "source = $OUTPUT" "$HYPR_CONF"; then
    echo "source = $OUTPUT" >> "$HYPR_CONF"
fi

# ─── Variables de estado del script ───────────────────────────────────────────

REVERSE=0          # 1 si se pasó -r (ciclo inverso)
ORIENT_MODE=0      # 1 si se pasó -o (modo orientación/dirección)
TARGET_ORIENT=""   # valor de orientación/dirección destino (si se pasó explícitamente)
TARGET_LAYOUT=""   # layout destino (si se pasó explícitamente)

# ─── Funciones auxiliares ──────────────────────────────────────────────────────

# Devuelve 0 si el layout soporta orientación/dirección, 1 si no
supports_orient() {
    for L in "${ORIENT_LAYOUTS[@]}"; do
        [[ "$L" == "$1" ]] && return 0
    done
    return 1
}

# Devuelve la clave de layoutopt que usa cada layout
# master    → orientation
# scrolling → direction
get_layoutopt_key() {
    case "$1" in
        master)    echo "orientation" ;;
        scrolling) echo "direction" ;;
    esac
}

# Devuelve la lista de valores válidos para el layout dado
get_layout_values() {
    case "$1" in
        master)    echo "${MASTER_ORIENTATIONS[@]}" ;;
        scrolling) echo "${SCROLLING_DIRECTIONS[@]}" ;;
    esac
}

# Aplica una orientación/dirección al layout activo vía hyprctl
# master:    usa layoutmsg orientation <value>
# scrolling: usa layoutmsg direction <value>
apply_orient() {
    local layout="$1" value="$2"
    case "$layout" in
        master)
            hyprctl dispatch layoutmsg "orientation ${value}"
            ;;
        scrolling)
            hyprctl dispatch layoutmsg "direction ${value}"
            ;;
    esac
}

# Escribe o actualiza la línea de layout para el workspace en workspace_layouts.conf
# Formato: workspace = <ws>, layout:<layout>
persist_layout() {
    local ws="$1" layout="$2"
    local line="workspace = $ws, layout:$layout"
    if grep -q "^workspace = $ws, layout:" "$OUTPUT"; then
        sed -i "s|^workspace = $ws, layout:.*|$line|" "$OUTPUT"
    else
        echo "$line" >> "$OUTPUT"
    fi
}

# Escribe o actualiza la línea de layoutopt para el workspace en workspace_layouts.conf
# Formato: workspace = <ws>, layoutopt:<key>:<value>
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

# Devuelve la orientación/dirección guardada para el workspace y layout dados.
# Primero busca en workspace_layouts.conf; si no hay entrada guardada, consulta
# hyprctl getoption para leer el estado real actual de Hyprland como fallback.
get_saved_orient() {
    local ws="$1" layout="$2"
    local key
    key=$(get_layoutopt_key "$layout")

    # Intentar leer desde el archivo persistido
    local saved
    saved=$(grep "^workspace = $ws, layoutopt:${key}:" "$OUTPUT" \
        | sed "s/.*layoutopt:${key}://" \
        | head -1)

    if [[ -n "$saved" ]]; then
        echo "$saved"
        return
    fi

    # Fallback: consultar el estado real de Hyprland si no hay entrada guardada.
    # hyprctl getoption devuelve JSON con campo "str" que contiene el valor actual.
    # Ejemplo: hyprctl getoption master:orientation -j → { "str": "left", ... }
    hyprctl getoption "${layout}:${key}" -j 2>/dev/null | jq -r '.str // empty'
}

# ─── Parseo de argumentos ──────────────────────────────────────────────────────

while [[ $# -gt 0 ]]; do
    case "$1" in
        -r)
            # Activar modo ciclo inverso
            REVERSE=1
            shift
            ;;
        -o)
            # Activar modo orientación/dirección
            ORIENT_MODE=1
            shift
            # Si el siguiente token no es un flag ni un layout conocido,
            # tratarlo provisionalmente como valor de orientación/dirección.
            # La validación real se hace más adelante cuando se conoce EFFECTIVE_LAYOUT.
            if [[ -n "$1" && "$1" != -* ]]; then
                MAYBE_ORIENT="$1"
                shift
            fi
            ;;
        *)
            # Intentar interpretar el token como un layout conocido
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

# ─── Leer estado actual del workspace activo ──────────────────────────────────

# WS:             ID numérico del workspace activo
# CURRENT_LAYOUT: layout activo en ese workspace (dwindle, master, etc.)
read WS CURRENT_LAYOUT < <(
    hyprctl activeworkspace -j | jq -r '[.id, .tiledLayout] | @tsv'
)

# ─── Modo orientación/dirección (-o) ──────────────────────────────────────────

if [[ $ORIENT_MODE -eq 1 ]]; then

    # Si se especificó un layout destino úsalo; si no, usa el layout activo
    EFFECTIVE_LAYOUT="${TARGET_LAYOUT:-$CURRENT_LAYOUT}"

    # Verificar que el layout efectivo soporte orientación/dirección
    if ! supports_orient "$EFFECTIVE_LAYOUT"; then
        echo "Error: -o solo aplica a master o scrolling (layout actual: $EFFECTIVE_LAYOUT)" >&2
        exit 1
    fi

    # Validar el valor provisional de orientación contra los valores del layout efectivo
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

    # Si el workspace no está en el layout destino, cambiarlo primero
    if [[ "$CURRENT_LAYOUT" != "$EFFECTIVE_LAYOUT" ]]; then
        hyprctl dispatch layoutmsg "setlayout $EFFECTIVE_LAYOUT"
        persist_layout "$WS" "$EFFECTIVE_LAYOUT"
        notify-send "⬡ Cambiando de Layout" \
            "${DISPLAY_NAMES[$CURRENT_LAYOUT]} → ${DISPLAY_NAMES[$EFFECTIVE_LAYOUT]}" \
            -i /usr/share/icons/Papirus/128x128/apps/pop-cosmic-workspaces.svg -u normal -t 1000
    fi

    # Leer orientación/dirección actual (desde archivo o desde Hyprland vía getoption)
    CURRENT_ORIENT=$(get_saved_orient "$WS" "$EFFECTIVE_LAYOUT")

    # Si aún no hay valor (primer uso sin entrada persistida ni estado en getoption),
    # tomar el primer valor de la lista como default
    [[ -z "$CURRENT_ORIENT" ]] && CURRENT_ORIENT="$(get_layout_values "$EFFECTIVE_LAYOUT" | awk '{print $1}')"

    if [[ -n "$TARGET_ORIENT" ]]; then
        # Saltar directamente al valor especificado
        NEW_ORIENT="$TARGET_ORIENT"
    else
        # Ciclar al siguiente (o anterior si -r) valor de la lista
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

    # Si ya estamos en el valor destino, notificar y salir sin hacer nada
    if [[ "$CURRENT_ORIENT" == "$NEW_ORIENT" ]]; then
        notify-send "Layout ${DISPLAY_NAMES[$EFFECTIVE_LAYOUT]}" \
            "Ya es ${ORIENT_NAMES[$NEW_ORIENT]}" \
            -i /usr/share/icons/Papirus/128x128/apps/pop-cosmic-workspaces.svg -u normal -t 1000
        exit 0
    fi

    # Aplicar la nueva orientación/dirección y persistirla
    apply_orient "$EFFECTIVE_LAYOUT" "$NEW_ORIENT"
    persist_orient "$WS" "$EFFECTIVE_LAYOUT" "$NEW_ORIENT"

    # Reordenar el archivo por número de workspace para mantenerlo legible
    sort -t '=' -k2 -n -o "$OUTPUT" "$OUTPUT"

    notify-send "⬡ ${DISPLAY_NAMES[$EFFECTIVE_LAYOUT]}" \
        "${ORIENT_NAMES[$CURRENT_ORIENT]} → ${ORIENT_NAMES[$NEW_ORIENT]}" \
        -i /usr/share/icons/Papirus/128x128/apps/pop-cosmic-workspaces.svg -u normal -t 1000
    exit 0
fi

# ─── Modo layout normal ────────────────────────────────────────────────────────

if [[ -n "$TARGET_LAYOUT" ]]; then
    # Saltar directamente al layout especificado
    TARGET="$TARGET_LAYOUT"
else
    # Ciclar al siguiente (o anterior si -r) layout de la lista
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

# Si ya estamos en el layout destino, notificar y salir sin hacer nada
if [[ "$CURRENT_LAYOUT" == "$TARGET" ]]; then
    notify-send "Layout" "Ya estás en ${DISPLAY_NAMES[$CURRENT_LAYOUT]}" \
        -i /usr/share/icons/Papirus/128x128/apps/pop-cosmic-workspaces.svg -u normal -t 1000
    exit 0
fi

# Aplicar el nuevo layout y persistirlo
hyprctl dispatch layoutmsg "setlayout $TARGET"
persist_layout "$WS" "$TARGET"

# Si el nuevo layout soporta orientación/dirección, restaurar el valor guardado
# para este workspace (si existe), y añadirlo a la notificación
ORIENT_SUFFIX=""
if supports_orient "$TARGET"; then
    SAVED_ORIENT=$(get_saved_orient "$WS" "$TARGET")
    if [[ -n "$SAVED_ORIENT" ]]; then
        apply_orient "$TARGET" "$SAVED_ORIENT"
        ORIENT_SUFFIX=" (${ORIENT_NAMES[$SAVED_ORIENT]})"
    fi
fi

# Reordenar el archivo por número de workspace para mantenerlo legible
sort -t '=' -k2 -n -o "$OUTPUT" "$OUTPUT"

notify-send "⬡ Cambiando de Layout" \
    "${DISPLAY_NAMES[$CURRENT_LAYOUT]} → ${DISPLAY_NAMES[$TARGET]}${ORIENT_SUFFIX}" \
    -i /usr/share/icons/Papirus/128x128/apps/pop-cosmic-workspaces.svg -u normal -t 1000
