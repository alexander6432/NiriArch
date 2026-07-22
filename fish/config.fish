# =========================
# CONFIGURACIÓN GENERAL
# =========================

# Quita el saludo inicial de fish
set -g fish_greeting ""

# Iniciar Starship
starship init fish | source

#Iniciar Zoxide
zoxide init fish | source

set -gx PATH $PATH (go env GOPATH)/bin

# =========================
# ALIASES
# =========================
# CD
function ... --description 'Sube dos niveles de directorio'
    cd ../..
end

function .... --description 'Sube tres niveles de directorio'
    cd ../../..
end

# SUDO HELIX
function shx --description 'Abre Helix como root con config personalizada'
    sudo helix -c $HOME/.config/helix/config.toml $argv
end

function hx --description 'Abre Helix'
    helix $argv
end

# ZELLIJ
function zz --description 'Inicia Zellij'
    zellij $argv
end

function za --description 'Adjunta a una sesión de Zellij'
    zellij attach $argv
end

function zs --description 'Crea una nueva sesión de Zellij'
    zellij -s $argv
end

function zls --description 'Lista sesiones activas de Zellij'
    zellij list-sessions
end

function zrm --description 'Elimina todas las sesiones de Zellij'
    zellij delete-all-sessions
end

# VENTOY
function ventoywayland --description 'Ejecuta Ventoy GUI bajo Wayland con permisos root'
    sudo env WAYLAND_DISPLAY=wayland-1 XDG_RUNTIME_DIR=/run/user/1000 ventoygui
end

# YAZI
function yy --description 'Abre Yazi y cambia de directorio al salir'
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and test -n "$cwd"; and test "$cwd" != "$PWD"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# SSH
function ssh-gen --description 'Genera un nuevo par de llaves SSH ed25519'
    read -P "Ingresa tu correo: " email
    ssh-keygen -t ed25519 -C "$email"
end

function ssh-testgithub --description 'Prueba la conexión SSH con GitHub'
    ssh -T git@github.com
end

# REFLECTOR
function update-mirrors --description 'Actualiza mirrors de pacman y el sistema'
    echo "🔄 Actualizando mirrors..."
    sudo reflector --country MX,US \
        --age 24 --latest 20 --protocol https --number 5 \
        --sort rate --save /etc/pacman.d/mirrorlist
    and echo "✅ Mirrors actualizados"
    and sudo pacman -Syyu
    and echo "📦 Sistema actualizado con éxito"
end
