-----------------------
---- MISCELLANEOUS ----
-----------------------

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift   = "SHIFT + "
local ctrl    = "CTRL + "

-- Set programs that you use
local chrome        = "google-chrome-stable"
local firefox       = "firefox"
local fileManager   = "nautilus"
local floatTerminal = "kitty --class='floatTerminal' fish"
local terminal      = "kitty fish"

local cheatsheet = "kitty --class='cheatsheet' ~/.config/scripts/cheatsheet_hyprland.sh"
local hyprExit   = "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"

local screenshot = "hyprshot -m output -m active -o ~/Imágenes/Capturas -f Captura_de_Pantalla_$(date +%F_%H-%M-%S).png"
local windowshot = "hyprshot -m window -m active -o ~/Imágenes/Capturas -f Captura_de_Ventana_$(date +%F_%H-%M-%S).png"
local areashot   = "hyprshot -m region -o ~/Imágenes/Capturas -f Captura_de_Area_$(date +%F_%H-%M-%S).png"

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

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. "Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. shift .."Return", hl.dsp.exec_cmd(floatTerminal))
hl.bind(mainMod .. "B", hl.dsp.exec_cmd(chrome))
hl.bind(mainMod .. shift .."B", hl.dsp.exec_cmd(firefox))
hl.bind(mainMod .. "E", hl.dsp.exec_cmd(fileManager))

local layouts = { "dwindle", "master", "scrolling" }
local ws_layout_idx = {}

local function next_layout()
  local ws = hl.get_active_workspace()
  if not ws then return end

  local idx = ws_layout_idx[ws.id] or 1
  for i, v in ipairs(layouts) do
    if v == ws.tiled_layout then idx = i; break end
  end

  local next_idx = (idx % #layouts) + 1
  ws_layout_idx[ws.id] = next_idx

  hl.workspace_rule({ workspace = tostring(ws.id), layout = layouts[next_idx] })
end

local hyprshutdown = hl.bind(mainMod .. ctrl .. "Escape", hl.dsp.exec_cmd(hyprExit))
hyprshutdown:set_enabled(true)
local help = hl.bind(mainMod .. "F1", hl.dsp.exec_cmd(cheatsheet))
help:set_enabled(true)

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

hl.bind("print", hl.dsp.exec_cmd(windowshot))
hl.bind(shift .."print", hl.dsp.exec_cmd(screenshot))
hl.bind(ctrl .."print", hl.dsp.exec_cmd(areashot))

hl.bind(mainMod .. "D", next_layout)
