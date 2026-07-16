--------------------
---- WORKSPACES ----
--------------------

local mainMod  = "SUPER + "      -- Sets "Windows" key as main modifier
local shift    = "SHIFT + "
local ctrl     = "CTRL + "
local plus     = "Period"
local minus    = "Comma"
local total_ws = 9

for i = 1, total_ws do
  local key = i % 10 -- si total_ws=10, el workspace 10 se pide con la tecla 0
  hl.bind(mainMod .. key, hl.dsp.focus({ workspace = i }), { desc = "Ir al workspace " .. key })
  hl.bind(mainMod .. shift .. key, hl.dsp.window.move({ workspace = i }), { desc = "Mover ventana al workspace " .. key })
  hl.bind(mainMod .. ctrl .. key, hl.dsp.window.move({ workspace = i, follow = false }),
    { desc = "Mover ventana al workspace " .. key .. " sin enfocarlo" })
end

local function make_nav(sign, wrap)
  local step = sign > 0 and "+1" or "-1"
  return {
    empty = "e" .. step,
    step  = step,
    wrap  = wrap,
    limit = sign > 0
        and function(id) return id < total_ws end
        or function(id) return id > 1 end,
  }
end

local workspace_nav = {
  after  = make_nav(1, 1),
  before = make_nav(-1, total_ws),
}

local actions = {
  move = function(nav, wa, follow)
    local target = nav.limit(wa.id) and nav.step or nav.wrap
    hl.dispatch(hl.dsp.window.move({ workspace = target, follow = follow }))
  end,
  focus = function(nav, wa)
    local target = (nav.limit(wa.id) and wa.windows > 0) and nav.step or nav.empty
    hl.dispatch(hl.dsp.focus({ workspace = target }))
  end,
}

local function relative_workspace(dir, action, follow)
  local nav = workspace_nav[dir]
  local fn = actions[action]
  return function()
    local wa = hl.get_active_workspace()
    if wa then fn(nav, wa, follow) end
  end
end

hl.bind(mainMod .. plus, relative_workspace("after", "focus"), { desc = "Ir al siguiente workspace" })

hl.bind(mainMod .. minus, relative_workspace("before", "focus"), { desc = "Ir al anterior workspace" })

hl.bind(mainMod .. shift .. plus, relative_workspace("after", "move", true),
  { desc = "Mover ventana al siguiente workspace" })

hl.bind(mainMod .. shift .. minus, relative_workspace("before", "move", true),
  { desc = "Mover ventana al anterior workspace" })

hl.bind(mainMod .. ctrl .. plus, relative_workspace("after", "move", false),
  { desc = "Mover ventana al siguiente workspace sin enfocarlo" })

hl.bind(mainMod .. ctrl .. minus, relative_workspace("before", "move", false),
  { desc = "Mover ventana al anterior workspace sin enfocarlo" })
