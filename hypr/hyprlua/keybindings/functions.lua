-------------------
---- FUNCTIONS ----
-------------------

local volumen_increase    = "qs -c noctalia-shell ipc call volume increase"
local volume_decrease     = "qs -c noctalia-shell ipc call volume decrease"
local mute_output         = "qs -c noctalia-shell ipc call volume muteOutput"
local mute_input          = "qs -c noctalia-shell ipc call volume muteInput"
local brightness_increase = "qs -c noctalia-shell ipc call brightness increase"
local brightness_decrease = "qs -c noctalia-shell ipc call brightness decrease"
local play_pause          = "qs -c noctalia-shell ipc call media playPause"
local stop                = "qs -c noctalia-shell ipc call media stop"
local previous            = "qs -c noctalia-shell ipc call media previous"
local next                = "qs -c noctalia-shell ipc call media next"

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd(volumen_increase), { locked = true, repeating = true, desc = "Aumentar el volumen" })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd(volume_decrease),  { locked = true, repeating = true, desc = "Reducir el volumen" })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd(mute_output),      { locked = true, desc = "Silenciar el audio" })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd(mute_input),       { locked = true, desc = "Silenciar el micrófono" })

hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(brightness_increase), { locked = true, repeating = true, desc = "Reducir el brillo" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(brightness_decrease), { locked = true, repeating = true, desc = "Aumentar el brillo" })

-- Requires playerctl
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd(play_pause), { locked = true, desc = "Pausar o reproducir multimedia" })
hl.bind("XF86AudioStop",  hl.dsp.exec_cmd(stop),       { locked = true, desc = "Detener multimedia" })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd(previous),   { locked = true, desc = "Anterior multimedia" })
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd(next),       { locked = true, desc = "Siguiente multimedia" })
