-----------------
---- WINDOWS ----
-----------------

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift   = "SHIFT + "
local ctrl    = "CTRL + "
local alt    = "ALT + "

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. "left",  hl.dsp.focus({ direction = "left" }),  { desc = "Enfocar ventana de la izquierda" })
hl.bind(mainMod .. "right", hl.dsp.focus({ direction = "right" }), { desc = "Enfocar ventana de la derecha" })
hl.bind(mainMod .. "up",    hl.dsp.focus({ direction = "up" }),    { desc = "Enfocar ventana de arriba" })
hl.bind(mainMod .. "down",  hl.dsp.focus({ direction = "down" }) , { desc = "Enfocar ventana de abajo" })

hl.bind(mainMod .. shift .. "left",  hl.dsp.window.move({ direction = "left" }), { desc = "Mover ventana a la izquierda"})
hl.bind(mainMod .. shift .. "right", hl.dsp.window.move({ direction = "right" }),{ desc = "Mover ventana a la derecha"})
hl.bind(mainMod .. shift .. "up",    hl.dsp.window.move({ direction = "up" }),   { desc = "Mover ventana a hacia arriba"})
hl.bind(mainMod .. shift .. "down",  hl.dsp.window.move({ direction = "down" }), { desc = "Mover ventana a hacia abajo"})

hl.bind(mainMod .. ctrl .. "left",  hl.dsp.window.move({ x = -20, y = 0,   relative = true }), { desc = "Mover ventana a la izquierda por pasos" })
hl.bind(mainMod .. ctrl .. "right", hl.dsp.window.move({ x = 20,  y = 0,   relative = true }), { desc = "Mover ventana a la derecha por pasos" })
hl.bind(mainMod .. ctrl .. "up",    hl.dsp.window.move({ x = 0,   y = -20, relative = true }), { desc = "Mover ventana a hacia arriba por pasos" })
hl.bind(mainMod .. ctrl .. "down",  hl.dsp.window.move({ x = 0,   y = 20,  relative = true }), { desc = "Mover ventana a hacia abajo por pasos" })

hl.bind(mainMod .. alt .. "left",  hl.dsp.window.resize({ x = -20, y = 0,   relative = true }), { repeating = true, desc = "Reducir el ancho de la ventana" })
hl.bind(mainMod .. alt .. "right", hl.dsp.window.resize({ x = 20,  y = 0,   relative = true }), { repeating = true, desc = "Aumentar el ancho de la ventana" })
hl.bind(mainMod .. alt .. "up",    hl.dsp.window.resize({ x = 0,   y = -20, relative = true }), { repeating = true, desc = "Aumentar el alto de la ventana" })
hl.bind(mainMod .. alt .. "down",  hl.dsp.window.resize({ x = 0,   y = 20,  relative = true }), { repeating = true, desc = "Reducir el alto de la ventana" })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. "mouse:272", hl.dsp.window.drag(),   { mouse = true, desc = "Mover ventana[mouse]" })
hl.bind(mainMod .. "ALT_L",     hl.dsp.window.resize(), { mouse = true, desc = "Redimensionar ventana[mouse]" })

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod ..          "Q", hl.dsp.window.close(),{ desc = "Cerrar ventana" })
hl.bind(mainMod .. shift .. "Q", hl.dsp.window.kill(), { desc = "Matar ventana" })

hl.bind(mainMod ..          "M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }),             { desc = "Maximizar ventana" })
hl.bind(mainMod .. shift .. "M", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),            { desc = "Pantalla completa" })
hl.bind(mainMod .. ctrl ..  "M", hl.dsp.window.fullscreen_state({ internal = 0, client = 3, action = "toggle" }), { desc = "Falsa pantalla completa" })

hl.bind(alt ..          "Tab", hl.dsp.window.cycle_next(),                    { desc = "Enfocar siguiente ventana" })
hl.bind(alt .. shift .. "Tab", hl.dsp.window.cycle_next({ next = false }),    { desc = "Enfocar anterior ventana" })
hl.bind(alt .. ctrl ..  "Tab", hl.dsp.window.cycle_next({ floating = true }), { desc = "Enfocar siguiente ventana flotante" })

hl.bind(mainMod ..          "U",  hl.dsp.focus({ urgent_or_last = true }), { desc = "Enfocar última ventana o la que requiere atención" })
hl.bind(mainMod .. shift .. "U",  hl.dsp.focus({ last = true }),           { desc = "Enfocar última ventana" })

hl.bind(mainMod .. shift .. "F", hl.dsp.window.pseudo({ action = "toggle" }), { desc = "Pseudo-flotante" })
hl.bind(mainMod ..          "P", hl.dsp.window.pin(),                         { desc = "Fijar ventana flotante" })
hl.bind(mainMod .. "C", hl.dsp.window.center(),                               { desc = "centrar ventana flotante" })

hl.bind(mainMod .. "F", function ()
  local scale = 0.70
  hl.dispatch(hl.dsp.window.float({ action = "toggle" }))

  local window = hl.get_active_window()
  if not window then return end

  if window.floating then
    local monitor = hl.get_active_monitor()
    if not monitor then return end

    local x = math.min(monitor.width * scale, window.size.x)
    local y = math.min(monitor.height * scale, window.size.y)

    hl.dispatch(hl.dsp.window.pseudo({ action = "disable" }))
    hl.dispatch(hl.dsp.window.resize({ x = x, y = y }))
    hl.dispatch(hl.dsp.window.center())
  end
end,
{ desc = "Alternar a ventana flotante" })
