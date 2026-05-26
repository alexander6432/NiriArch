local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift   = "SHIFT + "
local ctrl    = "CTRL + "
local min_key = "Apostrophe"
local toggle = "Exclamdown"

local special = "minimized"

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod ..          "Q", hl.dsp.window.close(), { desc = "Cerrar ventana" })
hl.bind(mainMod .. shift .. "Q", hl.dsp.window.kill(),  { desc = "Matar ventana" })

hl.bind(mainMod ..          "M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }),             { desc = "Maximizar ventana" })
hl.bind(mainMod .. shift .. "M", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }),            { desc = "Pantalla completa" })
hl.bind(mainMod .. ctrl ..  "M", hl.dsp.window.fullscreen_state({ internal = 0, client = 3, action = "toggle" }), { desc = "Falsa pantalla completa" })

hl.bind(mainMod .. shift .. "F", hl.dsp.window.pseudo({ action = "toggle" }), { desc = "Pseudo-flotante" })
hl.bind(mainMod ..          "P", hl.dsp.window.pin(),                         { desc = "Fijar ventana flotante" })
hl.bind(mainMod ..          "C", hl.dsp.window.center(),                      { desc = "centrar ventana flotante" })

hl.bind(mainMod ..         min_key,  hl.dsp.window.move({ workspace = "special:" .. special, follow = false }), { desc = "Minimizar Ventanas" })
hl.bind(mainMod .. shift .. min_key, hl.dsp.workspace.toggle_special(special),                                          { desc = "Ir al workspace de ventanas minimizadas" })

hl.bind(mainMod .. toggle, function ()
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
        function (a, b)
              return a.focus_history_id < b.focus_history_id
        end
    )
    hl.dispatch(hl.dsp.window.move({ workspace = wa.id, window = minimized[1] }))
  end
end,
{ desc = "Restaurar las ventanas minimizadas o minimizar la primera ventana" })

hl.bind(mainMod .. ctrl ..  "Q", function ()
  local wa = hl.get_active_workspace()
  if not wa then return end

  local ww = hl.get_workspace_windows(wa)

  for _, win in pairs(ww) do
    hl.dispatch(hl.dsp.window.close({window = win}))
  end

end,
{ desc = "Cerrar todas las ventanas del workspace actual" })

hl.bind(mainMod .. "F", function ()
  local scale = 0.70
  local win = hl.get_active_window()
  if not win then return end

  local monitor = hl.get_active_monitor()
  if not monitor then return end

  local x = math.min(monitor.width * scale, win.size.x)
  local y = math.min(monitor.height * scale, win.size.y)

  hl.dispatch(hl.dsp.window.float({ action = "toggle" }))

  win = hl.get_active_window()
  if not win then return end

  if win.floating then
    hl.dispatch(hl.dsp.window.pseudo({ action = "disable" }))
    hl.dispatch(hl.dsp.window.resize({ x = x, y = y }))
    hl.dispatch(hl.dsp.window.center())
  end
end,
{ desc = "Alternar a ventana flotante" })
