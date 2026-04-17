#!/bin/bash

# Uso: ./atajos_hypr.sh [grupos|ventanas]
modo="$1"

if [[ $modo == "submapa" ]]; then
  filtro="\[Submapa\]"
elif [[ $modo == "ventanas" ]]; then
  filtro="\[Modo Ventanas\]"
else
  filtro=""
fi

hyprctl binds | awk '
  function modmask_to_icons(mask,    result) {
    result = ""
    if (and(mask, 1))   result = result "󰘶 + "
    if (and(mask, 2))   result = result "󰘲 + "
    if (and(mask, 4))   result = result "󰘴 + "
    if (and(mask, 8))   result = result "󰌎 + "
    if (and(mask, 16))  result = result "NUM + "
    if (and(mask, 32))  result = result "SCROLL + "
    if (and(mask, 64))  result = result "󰖳 + "
    if (and(mask, 128)) result = result "ALTGR + "
    return result
  }

  function format_key(k,    parts) {
    if (k == "F1")                    return "󱊫"
    if (k == "F2")                    return "󱊬"
    if (k == "F3")                    return "󱊭"
    if (k == "F4")                    return "󱊮"
    if (k == "F5")                    return "󱊯"
    if (k == "F6")                    return "󱊰"
    if (k == "F7")                    return "󱊱"
    if (k == "F8")                    return "󱊲"
    if (k == "F9")                    return "󱊳"
    if (k == "F10")                   return "󱊴"
    if (k == "F11")                   return "󱊵"
    if (k == "F12")                   return "󱊶"
    if (k == "PRINT")                 return "󰹑"
    if (k == "Tab")                   return "󰌒"
    if (k == "XF86Audiolowervolume")  return "󰖀"
    if (k == "XF86Audiomicmute")      return "󰍭"
    if (k == "XF86Audiomute")         return "󰖁"
    if (k == "XF86Audionext")         return "󰒬"
    if (k == "XF86Audiopause")        return "󰐎"
    if (k == "XF86Audioplay")         return "󰐎"
    if (k == "XF86Audioprev")         return "󰒫"
    if (k == "XF86Audioraisevolume")  return "󰕾"
    if (k == "XF86Audiostop")         return "󰓛"
    if (k == "XF86Monbrightnessdown") return "󰃠"
    if (k == "XF86Monbrightnessup")   return "󰃞"
    if (k == "Apostrophe")            return "\x27"
    if (k == "ALT_L")                 return "󰌎"
    if (k == "Backspace")             return "󰌍"
    if (k == "Comma")                 return ","
    if (k == "Down")                  return "󰚶"
    if (k == "End")                   return "Fin"
    if (k == "Escape")                return "󱊷"
    if (k == "Left")                  return "󰨂"
    if (k == "Minus")                 return "-"
    if (k == "Mouse_down")            return "󱕐 Scroll"
    if (k == "Mouse_up")              return "󱕑 Scroll"
    if (k == "Page_down")             return "AvPág"
    if (k == "Period")                return "."
    if (k == "Plus")                  return "+"
    if (k == "Return")                return "󰌑"
    if (k == "Right")                 return "󰨃"
    if (k == "Space")                 return "󱁐"
    if (k == "Up")                    return "󰚷"
    if (k == "Home")                  return ""
    if (k ~ /^mouse:[0-9]+$/) {
      split(k, parts, ":")
      if (parts[2] == 272) return "󰍽 Izquierdo"
      if (parts[2] == 273) return "󰍽 Derecho"
      if (parts[2] == 274) return "󰍽 Medio"
      return "mouse " parts[2]
    }
    gsub(/^XF86/, "", k)
    return k
  }

  BEGIN {
    RESET  = "\033[0m"
    BOLD   = "\033[1m"
    CYAN   = "\033[36m"
    YELLOW = "\033[33m"
    DIM    = "\033[2m"
  }

  /^bind/ {
    getline; modmask  = $2
    getline; submap   = $2
    getline; key      = $2
    getline; keycode  = $2
    getline; catchall = $2
    getline; desc     = substr($0, index($0, $2))

    key_display = (key != "" ? key : (keycode != "" ? "KEYCODE_" keycode : catchall))
    key_display = format_key(key_display)
    atajo = modmask_to_icons(modmask) key_display

    printf CYAN   "%-20s" RESET, atajo
    printf YELLOW "%-70s\n" RESET, desc
  }
' | \
{
  if [[ -n $filtro ]]; then
    grep -E "$filtro"
  else
    grep -vE "\[Modo Grupos\]|\[Modo Ventanas\]"
  fi
} | \
grep -Pv "^(\x1b\[[0-9;]*m)*\s*(\x1b\[[0-9;]*m)*$" | \
fzf \
  --ansi \
  --header=" Atajos de Hyprland:  󰖳 = Super | 󰘶 = Shift | 󰘴 = Ctrl | 󰌎 = Alt" \
  --header-border=top \
  --footer="Atajo                    Descripción" \
  --prompt="󰍉 Buscar atajo: " \
  --height=80% \
  --border=rounded \
  --preview-window=hidden \
  --color='header:italic:yellow,prompt:cyan,pointer:magenta'
