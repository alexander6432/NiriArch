-----------------------
---- LAYOUT MASTER ----
-----------------------

local M = { binds = {} }

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift = "SHIFT + "
local ctrl = "CTRL + "

M.binds.cycle_next = hl.bind(mainMod .. "S", hl.dsp.layout("cyclenext loop"), { desc = "Enfocar siguiente ventana[master]" })
M.binds.cycle_prev = hl.bind(mainMod .. "A", hl.dsp.layout("cycleprev loop"), { desc = "Enfocar anterior ventana[master]" })

M.binds.swap_next = hl.bind(mainMod .. shift .. "S", hl.dsp.layout("swapnext loop"), { desc = "Intercambiar con la siguiente ventana[master]" })
M.binds.swap_prev = hl.bind(mainMod .. shift .. "A", hl.dsp.layout("swapprev loop"), { desc = "Intercambiar con la anterior ventana[master]" })

M.binds.roll_next = hl.bind(mainMod .. ctrl .. "S", hl.dsp.layout("rollnext"), { desc = "Rotar ventanas en sentido horario[master]" })
M.binds.roll_prev = hl.bind(mainMod .. ctrl .. "A", hl.dsp.layout("rollprev"), { desc = "Rotar ventanas en sentido antihorario[master]" })

M.binds.swap_master  = hl.bind(mainMod .. "I", hl.dsp.layout("swapwithmaster auto"), {desc = "Intercambiar con la ventana maestra[master]"})
M.binds.focus_master = hl.bind(mainMod .. "O", hl.dsp.layout("focusmaster auto"),    {desc = "Enfocar ventana maestra o la anterior[master]"})

M.binds.plus  = hl.bind(mainMod .. "Plus",  hl.dsp.layout("mfact +0.05"), { desc = "Aumentar relación de la ventana maestra[master]" })
M.binds.minus = hl.bind(mainMod .. "Minus", hl.dsp.layout("mfact -0.05"), { desc = "Reducir relación de la ventana maestra[master]" })

M.binds.orientation_n = hl.bind(mainMod ..          "Tab", hl.dsp.layout("orientationcycle left top right bottom"), { desc = "Rotar orientación en sentido horario para la ventana maestra[master]" })
M.binds.orientation_p = hl.bind(mainMod .. shift .. "Tab", hl.dsp.layout("orientationcycle bottom right top left"), { desc = "Rotar orientación en sentido antihorario para la ventana maestra[master]" })

M.binds.orientation_l = hl.bind(mainMod .. "H", hl.dsp.layout("orientationleft"),   { desc = "Ventana maestra con orientación a la izquierda[master]" })
M.binds.orientation_r = hl.bind(mainMod .. "L", hl.dsp.layout("orientationright"),  { desc = "Ventana maestra con orientación a la derecha[master]" })
M.binds.orientation_t = hl.bind(mainMod .. "K", hl.dsp.layout("orientationtop"),    { desc = "Ventana maestra con orientación hacia arriba[master]" })
M.binds.orientation_b = hl.bind(mainMod .. "J", hl.dsp.layout("orientationbottom"), { desc = "Ventana maestra con orientación hacia abajo[master]" })

M.binds.add_master    = hl.bind(mainMod .. shift .. "R", hl.dsp.layout("addmaster"),    { desc = "Agregar una ventana maestra[master]" })
M.binds.remove_master = hl.bind(mainMod ..          "R", hl.dsp.layout("removemaster"), { desc = "Remover una ventana maestra[master]" })

local function update_binds()
  local ws = hl.get_active_workspace()

  if not ws then
    return
  end

  local active = ws.tiled_layout == "master"

  for _, b in pairs(M.binds) do
    b:set_enabled(active)
  end

end

hl.timer(update_binds, {timeout = 200, type ="repeat"})

return M
