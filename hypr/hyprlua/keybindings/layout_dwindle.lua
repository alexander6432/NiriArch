------------------------
---- LAYOUT DWINDLE ----
------------------------

local M = {}

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier

local function on_dwindle(dispatcher)
  return function ()
    local wa = hl.get_active_workspace()
    if wa and wa.tiled_layout == "dwindle" then
      hl.dispatch(hl.dsp.layout(dispatcher))
    end
  end
end

function M.setup()

hl.bind(mainMod .. "A", on_dwindle("togglesplit"), { desc = "Alternar división[dwindle]" })    -- dwindle only
hl.bind(mainMod .. "S", on_dwindle("swapsplit"),   { desc = "Intercambiar división[dwindle]" })

hl.bind(mainMod .. "Plus",  on_dwindle("splitratio +0.05"), { desc = "Aumentar relación de la división[dwindle]" })
hl.bind(mainMod .. "Minus", on_dwindle("splitratio -0.05"), { desc = "Reducir relación de la división[dwindle]" })

hl.bind(mainMod .. "H", on_dwindle("preselect l"), { desc = "Izquierda para la siguiente ventana[dwindle]" })
hl.bind(mainMod .. "L", on_dwindle("preselect r"), { desc = "Derecha para la siguiente ventana[dwindle]" })
hl.bind(mainMod .. "K", on_dwindle("preselect u"), { desc = "Arriba para la siguiente ventana[dwindle]" })
hl.bind(mainMod .. "J", on_dwindle("preselect d"), { desc = "Abajo para la siguiente ventana[dwindle]" })

end

return M
