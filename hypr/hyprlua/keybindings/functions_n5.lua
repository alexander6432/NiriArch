----------------------
---- FUNCTIONS N5 ----
----------------------
local ctrl                = "CTRL + "

local volume_increase     = "noctalia msg volume-up 5"
local volume_decrease     = "noctalia msg volume-down 5"
local mic_increase        = "noctalia msg mic-volume-up 5"
local mic_decrease        = "noctalia msg mic-volume-down 5"
local mute_output         = "noctalia msg volume-mute"
local mute_input          = "noctalia msg mic-mute"
local brightness_increase = "noctalia msg brightness-up 5"
local brightness_decrease = "noctalia msg brightness-down 5"
local play_pause          = "noctalia msg media toggle"
local stop                = "noctalia msg media stop"
local previous            = "noctalia msg media previous"
local next                = "noctalia msg media next"

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(volume_increase),
  { locked = true, repeating = true, desc = "Aumentar el volumen" })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(volume_decrease),
  { locked = true, repeating = true, desc = "Reducir el volumen" })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(mute_output), { locked = true, desc = "Silenciar el audio" })

hl.bind(ctrl .. "XF86AudioRaiseVolume", hl.dsp.exec_cmd(mic_increase),
  { locked = true, repeating = true, desc = "Aumentar el volume del micrófono" })
hl.bind(ctrl .. "XF86AudioLowerVolume", hl.dsp.exec_cmd(mic_decrease),
  { locked = true, repeating = true, desc = "Reducir el volumen del micrófono" })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(mute_input), { locked = true, desc = "Silenciar el micrófono" })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(brightness_increase),
  { locked = true, repeating = true, desc = "Reducir el brillo" })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(brightness_decrease),
  { locked = true, repeating = true, desc = "Aumentar el brillo" })

-- Requires playerctl
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(play_pause), { locked = true, desc = "Pausar o reproducir multimedia" })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd(stop), { locked = true, desc = "Detener multimedia" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(previous), { locked = true, desc = "Anterior multimedia" })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(next), { locked = true, desc = "Siguiente multimedia" })
