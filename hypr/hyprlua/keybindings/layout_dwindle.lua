------------------------
---- LAYOUT DWINDLE ----
------------------------

local M = { binds = {} }

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier

M.binds.togglesplit = hl.bind(mainMod .. "A", hl.dsp.layout("togglesplit"))    -- dwindle only
M.binds.swapsplit   = hl.bind(mainMod .. "S", hl.dsp.layout("swapsplit"))

M.binds.ratio_up    = hl.bind(mainMod .. "plus", hl.dsp.layout("splitratio +0.05"))
M.binds.ratio_down  = hl.bind(mainMod .. "minus", hl.dsp.layout("splitratio -0.05"))

M.binds.presel_l    = hl.bind(mainMod .. "H", hl.dsp.layout("preselect l"))
M.binds.presel_r    = hl.bind(mainMod .. "L", hl.dsp.layout("preselect r"))
M.binds.presel_u    = hl.bind(mainMod .. "K", hl.dsp.layout("preselect u"))
M.binds.presel_d    = hl.bind(mainMod .. "J", hl.dsp.layout("preselect d"))

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

hl.on("workspace.active", update_binds )
hl.on("hyprland.start", update_binds )
hl.on("config.reloaded", update_binds )

return M
