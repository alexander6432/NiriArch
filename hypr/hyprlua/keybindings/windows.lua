-----------------
---- WINDOWS ----
-----------------

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift = "SHIFT + "
local ctrl = "CTRL + "
local alt = "ALT + "

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(
	mainMod .. shift .. "Left",
	hl.dsp.window.move({ direction = "left" }),
	{ desc = "Mover ventana a la izquierda" }
)
hl.bind(
	mainMod .. shift .. "Right",
	hl.dsp.window.move({ direction = "right" }),
	{ desc = "Mover ventana a la derecha" }
)
hl.bind(mainMod .. shift .. "Up", hl.dsp.window.move({ direction = "up" }), { desc = "Mover ventana a hacia arriba" })
hl.bind(
	mainMod .. shift .. "Down",
	hl.dsp.window.move({ direction = "down" }),
	{ desc = "Mover ventana a hacia abajo" }
)

hl.bind(
	mainMod .. ctrl .. "Left",
	hl.dsp.window.move({ x = -20, y = 0, relative = true }),
	{ repeating = true, desc = "Mover ventana a la izquierda por pasos" }
)
hl.bind(
	mainMod .. ctrl .. "Right",
	hl.dsp.window.move({ x = 20, y = 0, relative = true }),
	{ repeating = true, desc = "Mover ventana a la derecha por pasos" }
)
hl.bind(
	mainMod .. ctrl .. "Up",
	hl.dsp.window.move({ x = 0, y = -20, relative = true }),
	{ repeating = true, desc = "Mover ventana a hacia arriba por pasos" }
)
hl.bind(
	mainMod .. ctrl .. "Down",
	hl.dsp.window.move({ x = 0, y = 20, relative = true }),
	{ repeating = true, desc = "Mover ventana a hacia abajo por pasos" }
)

hl.bind(
	mainMod .. alt .. "Left",
	hl.dsp.window.resize({ x = -20, y = 0, relative = true }),
	{ repeating = true, desc = "Reducir el ancho de la ventana" }
)
hl.bind(
	mainMod .. alt .. "Right",
	hl.dsp.window.resize({ x = 20, y = 0, relative = true }),
	{ repeating = true, desc = "Aumentar el ancho de la ventana" }
)
hl.bind(
	mainMod .. alt .. "Up",
	hl.dsp.window.resize({ x = 0, y = -20, relative = true }),
	{ repeating = true, desc = "Aumentar el alto de la ventana" }
)
hl.bind(
	mainMod .. alt .. "Down",
	hl.dsp.window.resize({ x = 0, y = 20, relative = true }),
	{ repeating = true, desc = "Reducir el alto de la ventana" }
)

hl.bind(alt .. "Tab", hl.dsp.window.cycle_next({ next = true }), { desc = "Enfocar siguiente ventana" })
hl.bind(alt .. shift .. "Tab", hl.dsp.window.cycle_next({ next = false }), { desc = "Enfocar anterior ventana" })

hl.bind(mainMod .. "mouse:272", hl.dsp.window.drag(), { mouse = true, desc = "Mover ventana[mouse]" })
hl.bind(mainMod .. "ALT_L", hl.dsp.window.resize(), { mouse = true, desc = "Redimensionar ventana[mouse]" })

hl.bind(mainMod .. "Q", hl.dsp.window.close(), { desc = "Cerrar ventana" })
hl.bind(mainMod .. shift .. "Q", hl.dsp.window.kill(), { desc = "Matar ventana" })
hl.bind(mainMod .. ctrl .. "Q", function()
	local wa = hl.get_active_workspace()
	if not wa then
		return
	end
	for _, win in ipairs(hl.get_workspace_windows(wa)) do
		hl.dispatch(hl.dsp.window.close({ window = win }))
	end
end, { desc = "Cerrar todas las ventanas del workspace actual" })

hl.bind(
	mainMod .. shift .. "M",
	hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),
	{ desc = "Pantalla completa" }
)
hl.bind(
	mainMod .. ctrl .. "M",
	hl.dsp.window.fullscreen_state({ internal = 0, client = 3, action = "toggle" }),
	{ desc = "Falsa pantalla completa" }
)
hl.bind(mainMod .. "M", function()
	if hl.get_active_workspace().tiled_layout == "scrolling" then
		hl.dispatch(hl.dsp.layout("fit active"))
	else
		hl.dispatch(hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
	end
end, { desc = "Maximizar ventana" })

hl.bind(mainMod .. shift .. "F", hl.dsp.window.pseudo({ action = "toggle" }), { desc = "Pseudo-flotante" })
hl.bind(mainMod .. "F", function()
	local win = hl.get_active_window()
	local monitor = hl.get_active_monitor()
	if not win or not monitor then
		return
	end

	local scale = 0.75
	local x = math.min(monitor.width * scale, win.size.x)
	local y = math.min(monitor.height * scale, win.size.y)

	hl.dispatch(hl.dsp.window.float({ action = "toggle" }))

	if hl.get_active_window().floating then
		hl.dispatch(hl.dsp.window.resize({ x = x, y = y }))
		hl.dispatch(hl.dsp.window.center())
	end
end, { desc = "Alternar a ventana flotante" })

hl.bind(mainMod .. "P", hl.dsp.window.pin(), { desc = "Fijar ventana flotante" })
hl.bind(mainMod .. "C", hl.dsp.window.center(), { desc = "centrar ventana flotante" })

hl.bind(mainMod .. "V", hl.dsp.window.alter_zorder({ mode = "top" }), { desc = "Traer ventana flotante al frente" })
hl.bind(
	mainMod .. shift .. "V",
	hl.dsp.window.alter_zorder({ mode = "bottom" }),
	{ desc = "Llevar ventana flotante al fondo" }
)
