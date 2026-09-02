-----------------------
---- MISCELLANEOUS ----
-----------------------

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift = "SHIFT + "
local ctrl = "CTRL + "

local chrome = "google-chrome-stable"
local firefox = "firefox"
local file_manager = "nautilus"
local terminal = "kitty fish"
local yazi = "kitty fish -c yazi"

local cheat_sheet = "kitty ~/.config/scripts/cheatsheet_hyprland.sh"
local hypr_exit = "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"

local screenshot =
	"hyprshot -m output -m active -o ~/Imágenes/Capturas -f Captura_de_Pantalla_$(date +%F_%H-%M-%S).png"
local windowshot = "hyprshot -m window -m active -o ~/Imágenes/Capturas -f Captura_de_Ventana_$(date +%F_%H-%M-%S).png"
local areashot = "hyprshot -m region -o ~/Imágenes/Capturas -f Captura_de_Area_$(date +%F_%H-%M-%S).png"

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. "Return", hl.dsp.exec_cmd(terminal), { desc = "Abrir la terminal" })
hl.bind(mainMod .. "B", hl.dsp.exec_cmd(chrome), { desc = "Abrir google chrome" })
hl.bind(mainMod .. shift .. "B", hl.dsp.exec_cmd(firefox), { desc = "Abrir firefox" })
hl.bind(mainMod .. "E", hl.dsp.exec_cmd(file_manager), { desc = "Abrir explorador de archivos" })
hl.bind(mainMod .. shift .. "E", hl.dsp.exec_cmd(yazi), { desc = "Abrir yazi" })
hl.bind(mainMod .. ctrl .. "Escape", hl.dsp.exec_cmd(hypr_exit), { desc = "Forzar salida de hyprland" })

hl.bind("Print", hl.dsp.exec_cmd(windowshot), { desc = "Captura de ventana" })
hl.bind(shift .. "Print", hl.dsp.exec_cmd(screenshot), { desc = "Captura de pantalla" })
hl.bind(ctrl .. "Print", hl.dsp.exec_cmd(areashot), { desc = "Captura de pantalla por area" })

hl.bind(
	mainMod .. shift .. "Return",
	hl.dsp.exec_cmd(terminal, { float = true, size = { "(monitor_w * 0.5)", "(monitor_h * 0.5)" } }),
	{ desc = "Abrir terminal flotante" }
)

hl.bind(
	mainMod .. "F1",
	hl.dsp.exec_cmd(cheat_sheet, { float = true, size = { "(monitor_w * 0.6)", "(monitor_h * 0.4)" } }),
	{ desc = "Abrir buscador de atajos de teclado" }
)

local function get_active_workspace_any()
	return hl.get_active_special_workspace() or hl.get_active_workspace()
end

local function apply_layout(wa, layout)
	if wa.special then
		hl.workspace_rule({ workspace = tostring(wa.name), layout = layout })
	else
		hl.workspace_rule({ workspace = tostring(wa.id), layout = layout })
		hl.dispatch(hl.dsp.workspace.rename({ workspace = wa.id, name = layout }))
	end
end

local function set_layout(layout)
	return function()
		local wa = get_active_workspace_any()
		if not wa then
			return
		end
		apply_layout(wa, layout)
	end
end

local function change_layouts()
	local layouts = { "scrolling", "dwindle", "master", "monocle" }
	return function()
		local wa = get_active_workspace_any()
		if not wa then
			return
		end

		local next_layout = "dwindle"
		for i, v in ipairs(layouts) do
			if v == wa.tiled_layout then
				next_layout = layouts[(i % #layouts) + 1]
				break
			end
		end
		apply_layout(wa, next_layout)
	end
end

hl.bind(mainMod .. "F8", set_layout("dwindle"), { desc = "Layout dwindle" })
hl.bind(mainMod .. "F9", set_layout("master"), { desc = "Layout master" })
hl.bind(mainMod .. "F10", set_layout("monocle"), { desc = "Layout monocle" })
hl.bind(mainMod .. "F11", set_layout("scrolling"), { desc = "Layout scrolling" })
hl.bind(mainMod .. "F12", change_layouts(), { desc = "Cambiar de layouts" })
