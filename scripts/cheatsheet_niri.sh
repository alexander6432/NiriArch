#!/bin/bash

grep 'hotkey-overlay-title' ~/.config/niri/niri/binds.kdl | \
awk '
  BEGIN {
    sym["Xf86audiomicmute"]      = "󰍭"
    sym["Xf86audiomute"]         = "󰖁"
    sym["Xf86audionext"]         = "󰒬"
    sym["Xf86audiopause"]        = "󰐎"
    sym["Xf86audioplay"]         = "󰐎"
    sym["Xf86audioprev"]         = "󰒫"
    sym["Xf86audiostop"]         = "󰓛"
    sym["Xf86audiolowervolume"]  = "󰖀"
    sym["Xf86audioraisevolume"]  = "󰕾"
    sym["Xf86monbrightnessdown"] = "󰃠"
    sym["Xf86monbrightnessup"]   = "󰃞"
    sym["Left"]                  = "󰨂"
    sym["Right"]                 = "󰨃"
    sym["Down"]                  = "󰚶"
    sym["Up"]                    = "󰚷"
    sym["Backspace"]             = "󰌍"
    sym["Minus"]                 = "-"
    sym["Mod"]                   = "󰖳"
    sym["Super"]                 = "󰖳"
    sym["Alt"]                   = "󰌎"
    sym["Ctrl"]                  = "󰘴"
    sym["Shift"]                 = "󰘲"
    sym["Plus"]                  = "+"
    sym["Print"]                 = "󰹑"
    sym["Period"]                = "."
    sym["Comma"]                 = ","
    sym["Return"]                = "󰌑"
    sym["Space"]                 = "󱁐"
    sym["Tab"]                   = "󰌒"
    sym["U00BA"]                 = "º"
    sym["Escape"]                = "󱊷"
    sym["F1"]                    = "󱊫"
    sym["F2"]                    = "󱊬"
    sym["F3"]                    = "󱊭"
    sym["F4"]                    = "󱊮"
    sym["F5"]                    = "󱊯"
    sym["F6"]                    = "󱊰"
    sym["F7"]                    = "󱊱"
    sym["F8"]                    = "󱊲"
    sym["F9"]                    = "󱊳"
    sym["F10"]                   = "󱊴"
    sym["F11"]                   = "󱊵"
    sym["F12"]                   = "󱊶"
    sym["Home"]                  = ""
    sym["Touchpadscrollleft"]    = "← Scroll"
    sym["Touchpadscrollright"]   = "→ Scroll"
    sym["Touchpadscrolldown"]    = "↓ Scroll"
    sym["Touchpadscrollup"]      = "↑ Scroll"
  }
  {
    if (!match($0, /hotkey-overlay-title="([^"]+)"/, m)) next

    line = $0
    gsub(/^[[:space:]]+/, "", line)

    split(line, parts, " ")
    keybind = parts[1]
    desc    = m[1]

    # Dividir por "+" primero, sustituir cada token individualmente
    n = split(keybind, tokens, /\+/)
    result = ""
    for (i = 1; i <= n; i++) {
      t = tokens[i]
      # Capitalizar primera letra para que coincida con sym[]
      # (niri puede escribir "super" o "Super")
      t = toupper(substr(t,1,1)) tolower(substr(t,2))
      tok = (t in sym) ? sym[t] : t
      result = result (i > 1 ? " + " : "") tok
    }

    printf "%-15s %s\n", result, desc
  }
' | \
fzf \
  --header=" Atajos de Niri:  󰖳 = Super | 󰘲 = Shift | 󰘴 = Ctrl | 󰌎 = Alt" \
  --header-border=top \
  --footer="Atajo           Descripción" \
  --prompt="󰍉 Buscar atajo: " \
  --height=80% \
  --border=rounded \
  --preview-window=hidden \
  --color='header:italic:yellow,prompt:cyan,pointer:magenta'
