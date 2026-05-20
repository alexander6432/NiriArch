------------------------
---- LAYOUT MONOCLE ----
------------------------

local M = {}

local function on_monocle(dispatcher)
  return function()
    local ws = hl.get_active_workspace()
    if ws and ws.tiled_layout == "monocle" then
      hl.dispatch(dispatcher)
    end
  end
end

function M.setup()

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift = "SHIFT + "

hl.bind(mainMod ..          "Tab", on_monocle(hl.dsp.layout("cyclenext")), {desc = "Pasar a la siguiente ventana[monocle]" })
hl.bind(mainMod .. shift .. "Tab", on_monocle(hl.dsp.layout("cycleprev")), {desc = "Pasar a la anterior ventana[monocle]" })

end

return M
