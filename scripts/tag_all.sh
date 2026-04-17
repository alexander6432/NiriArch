#!/bin/bash

# Uso: tag-all.sh <+tag|-tag>
# Ejemplo: tag-all.sh +mytag   (agregar)
#          tag-all.sh -mytag   (quitar)

TAG="$1"

if [[ -z "$TAG" ]]; then
    echo "Uso: $0 <+tag|-tag>"
    exit 1
fi

hyprctl clients -j | jq -r '.[].address' | while read -r addr; do
    hyprctl dispatch tagwindow "$TAG address:$addr"
done
