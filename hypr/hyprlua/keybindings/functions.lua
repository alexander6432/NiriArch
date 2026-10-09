-------------------
---- FUNCTIONS ----
-------------------
local shift = "SHIFT + "

local vol_in = "noctalia msg volume-up 5"
local vol_de = "noctalia msg volume-down 5"
local mic_in = "noctalia msg mic-volume-up 5"
local mic_de = "noctalia msg mic-volume-down 5"
local mut_out = "noctalia msg volume-mute"
local mut_in = "noctalia msg mic-mute"
local bri_in = "noctalia msg brightness-up 5"
local bri_de = "noctalia msg brightness-down 5"
local play = "noctalia msg media toggle"
local stop = "noctalia msg media stop"
local prev = "noctalia msg media previous"
local next = "noctalia msg media next"

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(vol_in),
	{ locked = true, repeating = true, desc = "Aumentar el volumen" }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd(vol_de),
	{ locked = true, repeating = true, desc = "Reducir el volumen" }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(mut_out), { locked = true, desc = "Silenciar el audio" })

hl.bind(
	shift .. "XF86AudioRaiseVolume",
	hl.dsp.exec_cmd(mic_in),
	{ locked = true, repeating = true, desc = "Aumentar el volume del micrófono" }
)
hl.bind(
	shift .. "XF86AudioLowerVolume",
	hl.dsp.exec_cmd(mic_de),
	{ locked = true, repeating = true, desc = "Reducir el volumen del micrófono" }
)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(mut_in), { locked = true, desc = "Silenciar el micrófono" })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(bri_in), { locked = true, repeating = true, desc = "Reducir el brillo" })
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd(bri_de),
	{ locked = true, repeating = true, desc = "Aumentar el brillo" }
)

-- Requires playerctl
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(play), { locked = true, desc = "Pausar o reproducir multimedia" })
hl.bind("XF86AudioStop", hl.dsp.exec_cmd(stop), { locked = true, desc = "Detener multimedia" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(prev), { locked = true, desc = "Anterior multimedia" })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(next), { locked = true, desc = "Siguiente multimedia" })
