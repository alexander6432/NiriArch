-----------------------
---- LAYOUT MASTER ----
-----------------------

local M = { binds = {} }

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift = "SHIFT + "
local ctrl = "CTRL + "

M.binds.cycle_prev    =  hl.bind(mainMod .. "A", hl.dsp.layout("cycleprev loop"))
M.binds.cycle_next    =  hl.bind(mainMod .. "S", hl.dsp.layout("cyclenext loop"))

M.binds.swap_prev     =  hl.bind(mainMod .. shift .. "A", hl.dsp.layout("swapprev loop"))
M.binds.swap_next     =  hl.bind(mainMod .. shift .. "S", hl.dsp.layout("swapnext loop"))

M.binds.roll_prev     =  hl.bind(mainMod .. ctrl .. "A", hl.dsp.layout("rollprev"))
M.binds.roll_next     =  hl.bind(mainMod .. ctrl .. "S", hl.dsp.layout("rollnext"))

M.binds.swap_master   =  hl.bind(mainMod .. "I", hl.dsp.layout("swapwithmaster auto"))
M.binds.focus_master  =  hl.bind(mainMod .. "O", hl.dsp.layout("focusmaster auto"))

M.binds.plus          =  hl.bind(mainMod .. "plus", hl.dsp.layout("mfact +0.05"))
M.binds.minus         =  hl.bind(mainMod .. "minus", hl.dsp.layout("mfact -0.05"))

M.binds.orientation_n =  hl.bind(mainMod .. "Tab", hl.dsp.layout("orientationcycle left top right bottom"))
M.binds.orientation_p =  hl.bind(mainMod .. shift .. "Tab", hl.dsp.layout("orientationcycle bottom right top left"))

M.binds.remove_master =  hl.bind(mainMod .. "R", hl.dsp.layout("removemaster"))
M.binds.add_master    =  hl.bind(mainMod .. shift .. "R", hl.dsp.layout("addmaster"))

local function update_binds()
  local ws = hl.get_active_workspace()

  if not ws then
    return
  end

  local active = ws.tiled_layout == "master"

  for _, b in pairs (M.binds) do
    b:set_enabled(active)
  end

end

hl.timer(update_binds, {timeout = 200, type ="repeat"})

return M
