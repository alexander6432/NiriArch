---------------------
---- KEYBINDINGS ----
---------------------
local M = { binds = {} }

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift = "SHIFT + "

M.binds.cycle_next = hl.bind(mainMod .. "Tab", hl.dsp.layout("cyclenext"))
M.binds.cycle_prev = hl.bind(mainMod .. shift .. "Tab", hl.dsp.layout("cycleprev"))

local function update_binds()
  local ws = hl.get_active_workspace()

  if not ws then
    return
  end

  local active = ws.tiled_layout == "monocle"

  for _, b in pairs (M.binds) do
    b:set_enabled(active)
  end

end

hl.on("workspace.active", update_binds )
hl.on("hyprland.start", update_binds )
hl.on("config.reloaded", update_binds )

return M
