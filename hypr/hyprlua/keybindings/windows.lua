-----------------
---- WINDOWS ----
-----------------

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift   = "SHIFT + "
local ctrl    = "CTRL + "
local alt     = "ALT + "

local function cycle_next_float(next)
  return function()
    local wa = hl.get_active_workspace()
    if not wa then return end

    local win = hl.get_active_window()
    if not win then return end

    local windows = hl.get_workspace_windows(wa.id)

    local float = {}
    for _, w in pairs(windows) do
      if w.floating then table.insert(float, w) end
    end

    if #float > 0 and not win.floating then
      hl.dispatch(hl.dsp.window.cycle_next({ floating = true, next = next }))
    else
      hl.dispatch(hl.dsp.window.cycle_next({ next = next }))
    end
  end
end

hl.bind(mainMod .. "Left", hl.dsp.focus({ direction = "left" }), { desc = "Enfocar ventana de la izquierda" })
hl.bind(mainMod .. "Right", hl.dsp.focus({ direction = "right" }), { desc = "Enfocar ventana de la derecha" })
hl.bind(mainMod .. "Up", hl.dsp.focus({ direction = "up" }), { desc = "Enfocar ventana de arriba" })
hl.bind(mainMod .. "Down", hl.dsp.focus({ direction = "down" }), { desc = "Enfocar ventana de abajo" })

hl.bind(mainMod .. "U", hl.dsp.focus({ last = true }), { desc = "Enfocar última ventana" })
hl.bind(mainMod .. shift .. "U", hl.dsp.focus({ urgent_or_last = true }),
  { desc = "Enfocar última ventana o la que requiere atención" })

hl.bind(mainMod .. shift .. "Left", hl.dsp.window.move({ direction = "left" }), { desc = "Mover ventana a la izquierda" })
hl.bind(mainMod .. shift .. "Right", hl.dsp.window.move({ direction = "right" }), { desc = "Mover ventana a la derecha" })
hl.bind(mainMod .. shift .. "Up", hl.dsp.window.move({ direction = "up" }), { desc = "Mover ventana a hacia arriba" })
hl.bind(mainMod .. shift .. "Down", hl.dsp.window.move({ direction = "down" }), { desc = "Mover ventana a hacia abajo" })

hl.bind(mainMod .. ctrl .. "Left", hl.dsp.window.move({ x = -20, y = 0, relative = true }),
  { repeating = true, desc = "Mover ventana a la izquierda por pasos" })
hl.bind(mainMod .. ctrl .. "Right", hl.dsp.window.move({ x = 20, y = 0, relative = true }),
  { repeating = true, desc = "Mover ventana a la derecha por pasos" })
hl.bind(mainMod .. ctrl .. "Up", hl.dsp.window.move({ x = 0, y = -20, relative = true }),
  { repeating = true, desc = "Mover ventana a hacia arriba por pasos" })
hl.bind(mainMod .. ctrl .. "Down", hl.dsp.window.move({ x = 0, y = 20, relative = true }),
  { repeating = true, desc = "Mover ventana a hacia abajo por pasos" })

hl.bind(mainMod .. alt .. "Left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }),
  { repeating = true, desc = "Reducir el ancho de la ventana" })
hl.bind(mainMod .. alt .. "Right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }),
  { repeating = true, desc = "Aumentar el ancho de la ventana" })
hl.bind(mainMod .. alt .. "Up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }),
  { repeating = true, desc = "Aumentar el alto de la ventana" })
hl.bind(mainMod .. alt .. "Down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }),
  { repeating = true, desc = "Reducir el alto de la ventana" })

hl.bind(mainMod .. "mouse:272", hl.dsp.window.drag(), { mouse = true, desc = "Mover ventana[mouse]" })
hl.bind(mainMod .. "ALT_L", hl.dsp.window.resize(), { mouse = true, desc = "Redimensionar ventana[mouse]" })

hl.bind(alt .. "Tab", cycle_next_float(true), { desc = "Enfocar siguiente ventana" })
hl.bind(alt .. shift .. "Tab", cycle_next_float(false), { desc = "Enfocar anterior ventana" })
