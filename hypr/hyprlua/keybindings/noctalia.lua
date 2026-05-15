-----------------------
---- MISCELLANEOUS ----
-----------------------

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift   = "SHIFT + "
local ctrl    = "CTRL + "

local notificationsClear  = "qs -c noctalia-shell ipc call notifications clear"
local calendar            = "qs -c noctalia-shell ipc call calendar toggle"
local notificationsCenter = "qs -c noctalia-shell ipc call notifications toggleHistory"
local controlCenter       = "qs -c noctalia-shell ipc call controlCenter toggle"
local lockScreen          = "qs -c noctalia-shell ipc call lockScreen lock"
local idleInhibitor       = "qs -c noctalia-shell ipc call idleInhibitor toggle"
local launcher            = "qs -c noctalia-shell ipc call launcher toggle"
local sessionMenu         = "qs -c noctalia-shell ipc call sessionMenu toggle"
local bar                 = "qs -c noctalia-shell ipc call bar toggle"
local wallpaperRandom     = "qs -c noctalia-shell ipc call wallpaper random all"
local wallpaper           = "qs -c noctalia-shell ipc call wallpaper toggle"

hl.bind(mainMod .. "space", hl.dsp.exec_cmd(launcher))
hl.bind(mainMod .. shift .. " + L", hl.dsp.exec_cmd(lockScreen))
hl.bind(mainMod .. shift .. " + escape", hl.dsp.exec_cmd(sessionMenu))
hl.bind(mainMod .. "N", hl.dsp.exec_cmd(notificationsCenter))
hl.bind(mainMod .. shift .."N", hl.dsp.exec_cmd(notificationsClear))
hl.bind(mainMod .. shift .."C", hl.dsp.exec_cmd(controlCenter))
hl.bind(mainMod .. ctrl .."C", hl.dsp.exec_cmd(calendar))
hl.bind(mainMod .. "W", hl.dsp.exec_cmd(wallpaper))
hl.bind(mainMod .. shift .."W", hl.dsp.exec_cmd(wallpaperRandom))
hl.bind(mainMod .. "Z", hl.dsp.exec_cmd(idleInhibitor))
hl.bind(mainMod .. "X", hl.dsp.exec_cmd(bar))
