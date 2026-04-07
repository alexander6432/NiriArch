#!/bin/bash

ACTION="$1"   # workspace | movetoworkspace | movetoworkspacesilent
STEP="$2"     # +1, -1, +2, etc
MAX="$3"      # máximo de workspaces

# Validaciones básicas
if [[ -z "$ACTION" || -z "$STEP" || -z "$MAX" ]]; then
    echo "Uso: $0 <action> <+N|-N> <max>"
    exit 1
fi

# Obtener workspace actual
CURRENT=$(hyprctl activeworkspace -j | jq '.id')

# Calcular nuevo workspace
NEW=$((CURRENT + STEP))

# Wrap-around usando módulo
# Nota: bash modulo puede dar negativos, lo arreglamos
NEW=$(( (NEW - 1) % MAX + 1 ))

# Si quedó negativo, corregir
if (( NEW <= 0 )); then
    NEW=$((NEW + MAX))
fi

# Ejecutar acción
hyprctl dispatch "$ACTION" "$NEW"
