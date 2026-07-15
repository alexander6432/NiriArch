--------------------------
---- LAYOUT SCROLLING ----
--------------------------

local M = {}

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift = "SHIFT + "
local ctrl = "CTRL + "

local function on_scrolling(action, is_direction)
  return function()
    local wa = hl.get_active_workspace()
    if not wa or wa.tiled_layout ~= "scrolling" then return end
    if is_direction then
      hl.workspace_rule({ workspace = tostring(wa.id), layout_opts = { direction = action } })
    else
      hl.dispatch(hl.dsp.layout(action))
    end
  end
end

function M.setup()
  hl.bind(mainMod .. "R", on_scrolling("colresize +conf"),
    { desc = "Aumentar relación de ventana predefinido[scrolling]" })
  hl.bind(mainMod .. shift .. "R", on_scrolling("colresize -conf"),
    { desc = "Reducir relación de ventana predefinido[scrolling]" })

  hl.bind(mainMod .. "Plus", on_scrolling("colresize +0.05"), { desc = "Aumentar relacion de ventana[scrolling]" })
  hl.bind(mainMod .. "Minus", on_scrolling("colresize -0.05"), { desc = "Aumentar relacion de ventana[scrolling]" })

  hl.bind(mainMod .. "A", on_scrolling("fit visible"), { desc = "Ajustar ventanas visibles a la pantalla[scrolling]" })
  hl.bind(mainMod .. "S", on_scrolling("fit all"), { desc = "Ajustar  todas las ventanas a la pantalla[scrolling]" })

  hl.bind(mainMod .. shift .. "A", on_scrolling("swapcol l"),
    { desc = "Intercambiar ventana con la anterior[scrolling]" })
  hl.bind(mainMod .. shift .. "S", on_scrolling("swapcol r"),
    { desc = "Intercambiar ventana con la siguiente[scrolling]" })

  hl.bind(mainMod .. "G", on_scrolling("fit_into_view"),
    { desc = "Intercambiar ventana con la siguiente[scrolling]" })

  hl.bind(mainMod .. "I", on_scrolling("consume_or_expel prev"),
    { desc = "Consumir o expulsar con la anterior ventana[scrolling]" })
  hl.bind(mainMod .. "O", on_scrolling("consume_or_expel next"),
    { desc = "Consumir o expulsar con la siguiente ventana[scrolling]" })

  hl.bind(mainMod .. shift .. "I", on_scrolling("expel"), { desc = "Expulsar ventana[scrolling]" })
  hl.bind(mainMod .. shift .. "O", on_scrolling("consume"), { desc = "Consumir ventana[scrolling]" })

  hl.bind(mainMod .. "H", on_scrolling("left", true), { desc = "Cambiar orientación del scrolling[scrolling]" })
  hl.bind(mainMod .. "L", on_scrolling("right", true), { desc = "Cambiar orientación del scrolling[scrolling]" })
  hl.bind(mainMod .. "K", on_scrolling("up", true), { desc = "Cambiar orientación del scrolling[scrolling]" })
  hl.bind(mainMod .. "J", on_scrolling("down", true), { desc = "Cambiar orientación del scrolling[scrolling]" })
end

return M
