--------------------
---- WORKSPACES ----
--------------------

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift   = "SHIFT + "
local ctrl    = "CTRL + "
local plus = "Period"
local minus = "Comma"
local min_key = "Apostrophe"
local toggle = "Exclamdown"

local special = "minimized"

local workspace_nav = {
    after  = {
        empty = "e+1",
        step = "+1",
        wrap = 1,
        limit = function(id)
            return id < 10
        end
    },
    before = {
        empty = "e-1",
        step = "-1",
        wrap = 10,
        limit = function(id)
            return id > 1
        end
    },
}

local function relative_workspace(dir, action, follow)
    local nav = workspace_nav[dir]

    return function()
        local wa = hl.get_active_workspace()
        if not wa then return end

        if action == "move" then
            local target = nav.limit(wa.id) and nav.step or nav.wrap
            hl.dispatch(hl.dsp.window.move({ workspace = target, follow = follow }))
        end

        if action == "focus" then
            local target = (nav.limit(wa.id) and wa.windows > 0) and nav.step or nav.empty
            hl.dispatch(hl.dsp.focus({ workspace = target }))
        end
    end
end

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. key,          hl.dsp.focus({ workspace = i}),                        { desc = "Ir al workspace " .. key })
    hl.bind(mainMod .. shift .. key, hl.dsp.window.move({ workspace = i }),                 { desc = "Mover ventana al workspace " .. key })
    hl.bind(mainMod .. ctrl ..  key, hl.dsp.window.move({ workspace = i, follow = false }), { desc = "Mover ventana al workspace " .. key .. " sin enfocarlo" })
end

hl.bind(mainMod .. plus,  relative_workspace("after",  "focus"),  { desc = "Ir al siguiente workspace" })

hl.bind(mainMod .. minus, relative_workspace("before", "focus"), { desc = "Ir al anterior workspace" })

hl.bind(mainMod .. shift .. plus,  relative_workspace("after",  "move", true),  { desc = "Mover ventana al siguiente workspace" })

hl.bind(mainMod .. shift .. minus, relative_workspace("before", "move", true),  { desc = "Mover ventana al anterior workspace" })

hl.bind(mainMod .. ctrl .. plus,   relative_workspace("after",  "move", false), { desc = "Mover ventana al siguiente workspace sin enfocarlo" })

hl.bind(mainMod .. ctrl .. minus,  relative_workspace("before", "move", false), { desc = "Mover ventana al anterior workspace sin enfocarlo" })

hl.bind(mainMod ..         min_key,  hl.dsp.window.move({ workspace = "special:" .. special, follow = false }), { desc = "Minimizar Ventanas" })
hl.bind(mainMod .. shift .. min_key, hl.dsp.workspace.toggle_special(special),                                          { desc = "Ir al workspace de ventanas minimizadas" })

hl.bind(mainMod .. toggle, function()
  local wa = hl.get_active_workspace()
  if not wa then return end

  local windows = hl.get_windows()
  local target = "special:" .. special
  local minimized = {}

  for _, w in ipairs(windows) do
    if w.workspace.name == target then
      table.insert(minimized, w)
    end
  end

  if #minimized == 0 then
    hl.dispatch(hl.dsp.window.move({ workspace = target, follow = false }))
  else
    table.sort(
        minimized,
        function(a, b)
              return a.focus_history_id < b.focus_history_id
        end
    )
    hl.dispatch(hl.dsp.window.move({ workspace = wa.id, window = minimized[1] }))
  end
end,
{ desc = "Minimizar ventana o restaurar las ventanas minimizadas" })
