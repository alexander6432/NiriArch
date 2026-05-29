---------------------
---- NOCTALIA V4 ----
---------------------

local mainMod              = "SUPER + " -- Sets "Windows" key as main modifier
local shift                = "SHIFT + "
local ctrl                 = "CTRL + "

local bar                  = "qs -c noctalia-shell ipc call bar toggle"
local calendar             = "qs -c noctalia-shell ipc call calendar toggle"
local control_center       = "qs -c noctalia-shell ipc call controlCenter toggle"
local idle_inhibitor       = "qs -c noctalia-shell ipc call idleInhibitor toggle"
local launcher             = "qs -c noctalia-shell ipc call launcher toggle"
local screen_lock          = "qs -c noctalia-shell ipc call lockScreen lock"
local notifications_center = "qs -c noctalia-shell ipc call notifications toggleHistory"
local notifications_clear  = "qs -c noctalia-shell ipc call notifications clear"
local session_menu         = "qs -c noctalia-shell ipc call sessionMenu toggle"
local wallpaper            = "qs -c noctalia-shell ipc call wallpaper toggle"
local wallpaper_random     = "qs -c noctalia-shell ipc call wallpaper random all"

hl.bind(mainMod .. "Space", hl.dsp.exec_cmd(launcher), { desc = "Abrir launcher" })
hl.bind(mainMod .. shift .. "L", hl.dsp.exec_cmd(screen_lock), { desc = "Bloquear pantalla" })
hl.bind(mainMod .. shift .. "Escape", hl.dsp.exec_cmd(session_menu), { desc = "Abrir menú de sesión" })
hl.bind(mainMod .. "N", hl.dsp.exec_cmd(notifications_center), { desc = "Abrir centro de notificaciones" })
hl.bind(mainMod .. shift .. "N", hl.dsp.exec_cmd(notifications_clear), { desc = "Limpiar todas las notificaciones" })
hl.bind(mainMod .. shift .. "C", hl.dsp.exec_cmd(control_center), { desc = "Abrir centro de control" })
hl.bind(mainMod .. ctrl .. "C", hl.dsp.exec_cmd(calendar), { desc = "Abrir calendario" })
hl.bind(mainMod .. "W", hl.dsp.exec_cmd(wallpaper), { desc = "Abrir selector de fondos de pantallas" })
hl.bind(mainMod .. shift .. "W", hl.dsp.exec_cmd(wallpaper_random), { desc = "Cabiar fonde de pantalla aleatoriamente" })
hl.bind(mainMod .. "Z", hl.dsp.exec_cmd(idle_inhibitor), { desc = "Activar inhibidor" })
hl.bind(mainMod .. "X", hl.dsp.exec_cmd(bar), { desc = "Ocultar o mostrar barra de estado" })
