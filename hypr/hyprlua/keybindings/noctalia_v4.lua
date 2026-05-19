-----------------------
---- MISCELLANEOUS ----
-----------------------

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift   = "SHIFT + "
local ctrl    = "CTRL + "

local bar                 = "qs -c noctalia-shell ipc call bar toggle"
local calendar            = "qs -c noctalia-shell ipc call calendar toggle"
local controlCenter       = "qs -c noctalia-shell ipc call controlCenter toggle"
local idleInhibitor       = "qs -c noctalia-shell ipc call idleInhibitor toggle"
local launcher            = "qs -c noctalia-shell ipc call launcher toggle"
local lockScreen          = "qs -c noctalia-shell ipc call lockScreen lock"
local notificationsCenter = "qs -c noctalia-shell ipc call notifications toggleHistory"
local notificationsClear  = "qs -c noctalia-shell ipc call notifications clear"
local sessionMenu         = "qs -c noctalia-shell ipc call sessionMenu toggle"
local wallpaper           = "qs -c noctalia-shell ipc call wallpaper toggle"
local wallpaperRandom     = "qs -c noctalia-shell ipc call wallpaper random all"

hl.bind(mainMod ..          "Space",  hl.dsp.exec_cmd(launcher),            { desc = "Abrir launcher" })
hl.bind(mainMod .. shift .. "L",      hl.dsp.exec_cmd(lockScreen),          { desc = "Bloquear pantalla" })
hl.bind(mainMod .. shift .. "Escape", hl.dsp.exec_cmd(sessionMenu),         { desc = "Abrir menú de sesión" })
hl.bind(mainMod ..          "N",      hl.dsp.exec_cmd(notificationsCenter), { desc = "Abrir centro de notificaciones" })
hl.bind(mainMod .. shift .. "N",      hl.dsp.exec_cmd(notificationsClear),  { desc = "Limpiar todas las notificaciones" })
hl.bind(mainMod .. shift .. "C",      hl.dsp.exec_cmd(controlCenter),       { desc = "Abrir centro de control" })
hl.bind(mainMod .. ctrl ..  "C",      hl.dsp.exec_cmd(calendar),            { desc = "Abrir calendario" })
hl.bind(mainMod ..          "W",      hl.dsp.exec_cmd(wallpaper),           { desc = "Abrir selector de fondos de pantallas" })
hl.bind(mainMod .. shift .. "W",      hl.dsp.exec_cmd(wallpaperRandom),     { desc = "Cabiar fonde de pantalla aleatoriamente" })
hl.bind(mainMod ..          "Z",      hl.dsp.exec_cmd(idleInhibitor),       { desc = "Activar inhibidor" })
hl.bind(mainMod ..          "X",      hl.dsp.exec_cmd(bar),                 { desc = "Ocultar o mostrar barra de estado" })
