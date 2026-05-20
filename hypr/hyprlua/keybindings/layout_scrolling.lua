--------------------------
---- LAYOUT SCROLLING ----
--------------------------

local M = { binds = {} }

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift = "SHIFT + "
local ctrl = "CTRL + "

local function direction(dir)
  return function()
    local ws = hl.get_active_workspace()
    if not ws then return end

    hl.workspace_rule({ workspace = tostring(ws.id), layout_opts = {direction = dir }})
  end
end

M.binds.resize_conf_m = hl.bind(mainMod ..          "R", hl.dsp.layout("colresize +conf"), { desc = "Aumentar relación de ventana predefinido[scrolling]" })
M.binds.resize_conf_d = hl.bind(mainMod .. shift .. "R", hl.dsp.layout("colresize -conf"), { desc = "Reducir relación de ventana predefinido[scrolling]" })

M.binds.resize_u = hl.bind(mainMod .. "Plus",  hl.dsp.layout("colresize +0.05"), {desc = "Aumentar relacion de ventana[scrolling]" })
M.binds.resize_d = hl.bind(mainMod .. "Minus", hl.dsp.layout("colresize -0.05"), {desc = "Aumentar relacion de ventana[scrolling]" })

M.binds.swapcol_l = hl.bind(mainMod .. "A", hl.dsp.layout("swapcol l"), { desc = "Intercambiar ventana con la anterior[scrolling]"})
M.binds.swapcol_r = hl.bind(mainMod .. "S", hl.dsp.layout("swapcol r"), { desc = "Intercambiar ventana con la siguiente[scrolling]"})

M.binds.consume_expel_p = hl.bind(mainMod .. shift .. "A", hl.dsp.layout("consume_or_expel prev"), { desc = "Consumir o expulsar con la anterior ventana[scrolling]" })
M.binds.consume_expel_n = hl.bind(mainMod .. shift .. "S", hl.dsp.layout("consume_or_expel next"), { desc = "Consumir o expulsar con la siguiente ventana[scrolling]" })

M.binds.fit_visible = hl.bind(mainMod .. ctrl .. "A", hl.dsp.layout("fit visible"), { desc = "Ajustar ventanas visibles a la pantalla[scrolling]" })
M.binds.fit_all     = hl.bind(mainMod .. ctrl .. "S", hl.dsp.layout("fit all"),     { desc = "Ajustar  todas las ventanas a la pantalla[scrolling]" })

M.binds.expel   = hl.bind(mainMod .. "I", hl.dsp.layout("expel"),   { desc = "Expulsar ventana[scrolling]" })
M.binds.consume = hl.bind(mainMod .. "O", hl.dsp.layout("consume"), { desc = "Consumir ventana[scrolling]" })

M.binds.dir_l = hl.bind(mainMod .."H", direction("left"),  { desc = "Cambiar orientación del scrolling[scrolling]" })
M.binds.dir_r = hl.bind(mainMod .."L", direction("right"), { desc = "Cambiar orientación del scrolling[scrolling]" })
M.binds.dir_u = hl.bind(mainMod .."K", direction("up"),    { desc = "Cambiar orientación del scrolling[scrolling]" })
M.binds.dir_d = hl.bind(mainMod .."J", direction("down"),  { desc = "Cambiar orientación del scrolling[scrolling]" })

local function update_binds()
  local ws = hl.get_active_workspace()

  if not ws then
    return
  end

  local active = ws.tiled_layout == "scrolling"

  for _, b in pairs(M.binds) do
    b:set_enabled(active)
  end

end

hl.timer(update_binds, {timeout = 200, type ="repeat"})

return M
