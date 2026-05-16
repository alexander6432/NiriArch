------------------------
---- LAYOUT DWINDLE ----
------------------------

local M = { binds = {} }

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier

M.binds.togglesplit = hl.bind(mainMod .. "A", hl.dsp.layout("togglesplit"), { desc = "Alternar división[dwindle]" })    -- dwindle only
M.binds.swapsplit   = hl.bind(mainMod .. "S", hl.dsp.layout("swapsplit"),   { desc = "Intercambiar división[dwindle]" })

M.binds.ratio_up    = hl.bind(mainMod .. "Plus",  hl.dsp.layout("splitratio +0.05"), { desc = "Aumentar relación de la división[dwindle]" })
M.binds.ratio_down  = hl.bind(mainMod .. "Minus", hl.dsp.layout("splitratio -0.05"), { desc = "Reducir relación de la división[dwindle]" })

M.binds.presel_l    = hl.bind(mainMod .. "H", hl.dsp.layout("preselect l"), { desc = "Izquierda para la siguiente ventana[dwindle]" })
M.binds.presel_r    = hl.bind(mainMod .. "L", hl.dsp.layout("preselect r"), { desc = "Derecha para la siguiente ventana[dwindle]" })
M.binds.presel_u    = hl.bind(mainMod .. "K", hl.dsp.layout("preselect u"), { desc = "Arriba para la siguiente ventana[dwindle]" })
M.binds.presel_d    = hl.bind(mainMod .. "J", hl.dsp.layout("preselect d"), { desc = "Abajo para la siguiente ventana[dwindle]" })

local function update_binds()
  local ws = hl.get_active_workspace()

  if not ws then
    return
  end

  local active = ws.tiled_layout == "dwindle"

  for _, b in pairs (M.binds) do
    b:set_enabled(active)
  end

end

hl.timer(update_binds, {timeout = 200, type ="repeat"})

return M
