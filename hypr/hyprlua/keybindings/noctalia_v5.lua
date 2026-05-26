-----------------------
---- MISCELLANEOUS ----
-----------------------

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift   = "SHIFT + "
local ctrl    = "CTRL + "

local bar                  = "noctalia msg bar-toggle"
local calendar             = "noctalia msg panel-toggle control-center calendar"
local control_center       = "noctalia msg panel-toggle control-center"
local idle_inhibitor       = "noctalia msg caffeine-toggle"
local launcher             = "noctalia msg panel-toggle launcher"
local screen_lock          = "noctalia msg screen-lock"
local notifications_center = "noctalia msg panel-toggle control-center notifications"
local notifications_clear  = "noctalia msg notification-clear-history"
local session_menu         = "noctalia msg panel-toggle session"
local settings             = "noctalia msg settings-toggle"
local wallpaper            = "noctalia msg panel-toggle wallpaper"
local wallpaper_random     = "noctalia msg wallpaper-random"

hl.bind(mainMod ..          "Space",  hl.dsp.exec_cmd(launcher),             { desc = "Abrir launcher" })
hl.bind(mainMod .. shift .. "L",      hl.dsp.exec_cmd(screen_lock),          { desc = "Bloquear pantalla" })
hl.bind(mainMod .. shift .. "Escape", hl.dsp.exec_cmd(session_menu),         { desc = "Abrir menú de sesión" })
hl.bind(mainMod ..          "N",      hl.dsp.exec_cmd(notifications_center), { desc = "Abrir centro de notificaciones" })
hl.bind(mainMod .. shift .. "N",      hl.dsp.exec_cmd(notifications_clear),  { desc = "Limpiar todas las notificaciones" })
hl.bind(mainMod .. shift .. "C",      hl.dsp.exec_cmd(control_center),       { desc = "Abrir centro de control" })
hl.bind(mainMod .. ctrl ..  "C",      hl.dsp.exec_cmd(calendar),             { desc = "Abrir calendario" })
hl.bind(mainMod ..          "W",      hl.dsp.exec_cmd(wallpaper),            { desc = "Abrir selector de fondos de pantallas" })
hl.bind(mainMod .. shift .. "W",      hl.dsp.exec_cmd(wallpaper_random),     { desc = "Cabiar fonde de pantalla aleatoriamente" })
hl.bind(mainMod ..          "Z",      hl.dsp.exec_cmd(idle_inhibitor),       { desc = "Activar inhibidor" })
hl.bind(mainMod ..          "X",      hl.dsp.exec_cmd(bar),                  { desc = "Ocultar o mostrar barra de estado" })
hl.bind(mainMod .. shift .. "X",      hl.dsp.exec_cmd(settings),             { desc = "Configurición de noctalia" })
