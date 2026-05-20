--------------------
---- WORKSPACES ----
--------------------

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift   = "SHIFT + "
local ctrl    = "CTRL + "
local plus = "Period"
local minus = "Comma"
local special_key = "Apostrophe"

local special = "magic"

local function workspace_nav(direction, action, follow)
  return function()
    local ws = hl.get_active_workspace()
    if not ws then return end

    local forward  = direction == "next"
    local at_limit = forward and ws.id >= 10 or ws.id <= 1
    local wrap_to  = forward and "1" or "10"
    local relative = forward and "+1" or "-1"

    if action == "focus" then
      if at_limit then
        hl.dispatch(hl.dsp.focus({ workspace = forward and "e+1" or "e-1" }))
      else
        hl.dispatch(hl.dsp.focus({ workspace = relative }))
      end
    else
      local target = at_limit and wrap_to or relative
      hl.dispatch(hl.dsp.window.move({ workspace = target, follow = follow }))
    end
  end
end

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. key,          hl.dsp.focus({ workspace = i}),                        { desc = "Ir al workspace " .. key })
    hl.bind(mainMod .. shift .. key, hl.dsp.window.move({ workspace = i }),                 { desc = "Mover ventana al workspace " .. key })
    hl.bind(mainMod .. ctrl ..  key, hl.dsp.window.move({ workspace = i, follow = false }), { desc = "Mover ventana al workspace " .. key .. " sin enfocarlo" })
end

hl.bind(mainMod .. special_key,          hl.dsp.workspace.toggle_special(special),                                  { desc = "Ir al workspace especial: " .. special })
hl.bind(mainMod .. shift .. special_key, hl.dsp.window.move({ workspace = "special:" .. special }),                 { desc = "Mover ventana al workspace especial: " .. special })
hl.bind(mainMod .. ctrl ..  special_key, hl.dsp.window.move({ workspace = "special:" .. special, follow = false }), { desc = "Mover ventana al workspace especial: " .. special .. " sin enfocarlo" })

hl.bind(mainMod .. plus,  workspace_nav("next", "focus"),       { desc = "Ir al siguiente workspace" })
hl.bind(mainMod .. minus, workspace_nav("prev", "focus"),       { desc = "Ir al anterior workspace" })

hl.bind(mainMod .. shift .. plus,  workspace_nav("next", "move", true),  { desc = "Mover ventana al siguiente workspace" })
hl.bind(mainMod .. shift .. minus, workspace_nav("prev", "move", true),  { desc = "Mover ventana al anterior workspace" })

hl.bind(mainMod .. ctrl .. plus,  workspace_nav("next", "move", false), { desc = "Mover ventana al siguiente workspace sin enfocarlo" })
hl.bind(mainMod .. ctrl .. minus, workspace_nav("prev", "move", false), { desc = "Mover ventana al anterior workspace sin enfocarlo" })
