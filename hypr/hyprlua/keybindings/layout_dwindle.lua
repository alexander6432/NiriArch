------------------------
---- LAYOUT DWINDLE ----
------------------------

local M = {}

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier

local function on_dwindle(dispatcher)
  return function()
    local ws = hl.get_active_workspace()
    if ws and ws.tiled_layout == "dwindle" then
      hl.dispatch(dispatcher)
    end
  end
end

function M.setup()

hl.bind(mainMod .. "A", on_dwindle(hl.dsp.layout("togglesplit")), { desc = "Alternar división[dwindle]" })    -- dwindle only
hl.bind(mainMod .. "S", on_dwindle(hl.dsp.layout("swapsplit")),   { desc = "Intercambiar división[dwindle]" })

hl.bind(mainMod .. "Plus",  on_dwindle(hl.dsp.layout("splitratio +0.05")), { desc = "Aumentar relación de la división[dwindle]" })
hl.bind(mainMod .. "Minus", on_dwindle(hl.dsp.layout("splitratio -0.05")), { desc = "Reducir relación de la división[dwindle]" })

hl.bind(mainMod .. "H", on_dwindle(hl.dsp.layout("preselect l")), { desc = "Izquierda para la siguiente ventana[dwindle]" })
hl.bind(mainMod .. "L", on_dwindle(hl.dsp.layout("preselect r")), { desc = "Derecha para la siguiente ventana[dwindle]" })
hl.bind(mainMod .. "K", on_dwindle(hl.dsp.layout("preselect u")), { desc = "Arriba para la siguiente ventana[dwindle]" })
hl.bind(mainMod .. "J", on_dwindle(hl.dsp.layout("preselect d")), { desc = "Abajo para la siguiente ventana[dwindle]" })

end

return M
