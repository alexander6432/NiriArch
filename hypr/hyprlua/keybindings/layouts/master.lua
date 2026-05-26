-----------------------
---- LAYOUT MASTER ----
-----------------------

local M = {}

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift = "SHIFT + "
local ctrl = "CTRL + "

local function on_master(dispatcher)
  return function ()
    local wa = hl.get_active_workspace()
    if wa and wa.tiled_layout == "master" then
      hl.dispatch(hl.dsp.layout(dispatcher))
    end
  end
end

function M.setup()

hl.bind(mainMod .. "S", on_master("cyclenext loop"), { desc = "Enfocar siguiente ventana[master]" })
hl.bind(mainMod .. "A", on_master("cycleprev loop"), { desc = "Enfocar anterior ventana[master]" })

hl.bind(mainMod .. shift .. "S", on_master("swapnext loop"), { desc = "Intercambiar con la siguiente ventana[master]" })
hl.bind(mainMod .. shift .. "A", on_master("swapprev loop"), { desc = "Intercambiar con la anterior ventana[master]" })

hl.bind(mainMod .. ctrl .. "S", on_master("rollnext"), { desc = "Rotar ventanas en sentido horario[master]" })
hl.bind(mainMod .. ctrl .. "A", on_master("rollprev"), { desc = "Rotar ventanas en sentido antihorario[master]" })

hl.bind(mainMod .. "I", on_master("swapwithmaster auto"), {desc = "Intercambiar con la ventana maestra[master]"})
hl.bind(mainMod .. "O", on_master("focusmaster auto"),    {desc = "Enfocar ventana maestra o la anterior[master]"})

hl.bind(mainMod .. "Plus",  on_master("mfact +0.05"), { desc = "Aumentar relación de la ventana maestra[master]" })
hl.bind(mainMod .. "Minus", on_master("mfact -0.05"), { desc = "Reducir relación de la ventana maestra[master]" })

hl.bind(mainMod ..          "Tab", on_master("orientationcycle left top right bottom"), { desc = "Rotar orientación en sentido horario para la ventana maestra[master]" })
hl.bind(mainMod .. shift .. "Tab", on_master("orientationcycle bottom right top left"), { desc = "Rotar orientación en sentido antihorario para la ventana maestra[master]" })

hl.bind(mainMod .. "H", on_master("orientationleft"),   { desc = "Ventana maestra con orientación a la izquierda[master]" })
hl.bind(mainMod .. "L", on_master("orientationright"),  { desc = "Ventana maestra con orientación a la derecha[master]" })
hl.bind(mainMod .. "K", on_master("orientationtop"),    { desc = "Ventana maestra con orientación hacia arriba[master]" })
hl.bind(mainMod .. "J", on_master("orientationbottom"), { desc = "Ventana maestra con orientación hacia abajo[master]" })

hl.bind(mainMod .. shift .. "R", on_master("addmaster"),    { desc = "Agregar una ventana maestra[master]" })
hl.bind(mainMod ..          "R", on_master("removemaster"), { desc = "Remover una ventana maestra[master]" })

end

return M
