-----------------------
---- WINDOWS STATE ----
-----------------------

local mainMod    = "SUPER + " -- Sets "Windows" key as main modifier

local min_key    = 0
local toggle_key = "Apostrophe"
local wss        = "Exclamdown"

local special    = "minimized"

hl.bind(mainMod .. "Left", hl.dsp.focus({ direction = "left" }), { desc = "Enfocar ventana de la izquierda" })
hl.bind(mainMod .. "Right", hl.dsp.focus({ direction = "right" }), { desc = "Enfocar ventana de la derecha" })
hl.bind(mainMod .. "Up", hl.dsp.focus({ direction = "up" }), { desc = "Enfocar ventana de arriba" })
hl.bind(mainMod .. "Down", hl.dsp.focus({ direction = "down" }), { desc = "Enfocar ventana de abajo" })

hl.bind(mainMod .. "U", hl.dsp.focus({ urgent_or_last = true }),
  { desc = "Enfocar última ventana o la que requiere atención" })

hl.bind(mainMod .. min_key, hl.dsp.window.move({ workspace = "special:" .. special, follow = false }),
  { desc = "Minimizar ventanas" })
hl.bind(mainMod .. wss, hl.dsp.workspace.toggle_special(special),
  { desc = "Ir al workspace de ventanas minimizadas" })
hl.bind(mainMod .. toggle_key, function()
    local wa = hl.get_active_workspace()
    if not wa then return end

    local windows = hl.get_windows()
    local target = "special:" .. special
    local minimized = {}

    for _, w in ipairs(windows) do
      if w.workspace.name == target then
        table.insert(minimized, w)
      end
    end

    if #minimized == 0 then
      hl.dispatch(hl.dsp.window.move({ workspace = target, follow = false }))
    else
      table.sort(
        minimized,
        function(a, b)
          return a.focus_history_id < b.focus_history_id
        end
      )
      hl.dispatch(hl.dsp.window.move({ workspace = wa.id, window = minimized[1] }))
    end
  end,
  { desc = "Restaurar las ventanas minimizadas o minimizar la primera ventana" })
