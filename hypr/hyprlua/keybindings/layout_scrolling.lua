--------------------------
---- LAYOUT SCROLLING ----
--------------------------

local M = {}

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift = "SHIFT + "
local ctrl = "CTRL + "

local function on_scrolling(action, is_direction)
  return function()
    local ws = hl.get_active_workspace()
    if not ws or ws.tiled_layout ~= "scrolling" then return end
    if is_direction then
      hl.workspace_rule({ workspace = tostring(ws.id), layout_opts = { direction = action } })
    else
      hl.dispatch(action)
    end
  end
end

function M.setup()

hl.bind(mainMod ..          "R", on_scrolling(hl.dsp.layout("colresize +conf")), { desc = "Aumentar relación de ventana predefinido[scrolling]" })
hl.bind(mainMod .. shift .. "R", on_scrolling(hl.dsp.layout("colresize -conf")), { desc = "Reducir relación de ventana predefinido[scrolling]" })

hl.bind(mainMod .. "Plus",  on_scrolling(hl.dsp.layout("colresize +0.05")), {desc = "Aumentar relacion de ventana[scrolling]" })
hl.bind(mainMod .. "Minus", on_scrolling(hl.dsp.layout("colresize -0.05")), {desc = "Aumentar relacion de ventana[scrolling]" })

hl.bind(mainMod .. "A", on_scrolling(hl.dsp.layout("swapcol l")), { desc = "Intercambiar ventana con la anterior[scrolling]"})
hl.bind(mainMod .. "S", on_scrolling(hl.dsp.layout("swapcol r")), { desc = "Intercambiar ventana con la siguiente[scrolling]"})

hl.bind(mainMod .. shift .. "A", on_scrolling(hl.dsp.layout("consume_or_expel prev")), { desc = "Consumir o expulsar con la anterior ventana[scrolling]" })
hl.bind(mainMod .. shift .. "S", on_scrolling(hl.dsp.layout("consume_or_expel next")), { desc = "Consumir o expulsar con la siguiente ventana[scrolling]" })

hl.bind(mainMod .. ctrl .. "A", on_scrolling(hl.dsp.layout("fit visible")), { desc = "Ajustar ventanas visibles a la pantalla[scrolling]" })
hl.bind(mainMod .. ctrl .. "S", on_scrolling(hl.dsp.layout("fit all")),     { desc = "Ajustar  todas las ventanas a la pantalla[scrolling]" })

hl.bind(mainMod .. "I", on_scrolling(hl.dsp.layout("expel")),   { desc = "Expulsar ventana[scrolling]" })
hl.bind(mainMod .. "O", on_scrolling(hl.dsp.layout("consume")), { desc = "Consumir ventana[scrolling]" })

hl.bind(mainMod .."H", on_scrolling("left", true),  { desc = "Cambiar orientación del scrolling[scrolling]" })
hl.bind(mainMod .."L", on_scrolling("right", true), { desc = "Cambiar orientación del scrolling[scrolling]" })
hl.bind(mainMod .."K", on_scrolling("up", true),    { desc = "Cambiar orientación del scrolling[scrolling]" })
hl.bind(mainMod .."J", on_scrolling("down", true),  { desc = "Cambiar orientación del scrolling[scrolling]" })

end

return M
