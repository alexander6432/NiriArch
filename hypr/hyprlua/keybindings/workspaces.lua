--------------------
---- WORKSPACES ----
--------------------

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift   = "SHIFT + "
local ctrl    = "CTRL + "

local special_key = "Apostrophe"

local special = "magic"

local plus = "Period"
local minus = "Comma"

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. key,          hl.dsp.focus({ workspace = i}),                        { desc = "Ir al workspace " .. key })
    hl.bind(mainMod .. shift .. key, hl.dsp.window.move({ workspace = i }),                 { desc = "Mover ventana al workspace " .. key })
    hl.bind(mainMod .. ctrl ..  key, hl.dsp.window.move({ workspace = i, follow = false }), { desc = "Mover ventana al workspace " .. key .. " sin enfocarlo" })
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. special_key,          hl.dsp.workspace.toggle_special(special),                                  { desc = "Ir al workspace especial: " .. special })
hl.bind(mainMod .. shift .. special_key, hl.dsp.window.move({ workspace = "special:" .. special }),                 { desc = "Mover ventana al workspace especial: " .. special })
hl.bind(mainMod .. ctrl ..  special_key, hl.dsp.window.move({ workspace = "special:" .. special, follow = false }), { desc = "Mover ventana al workspace especial: " .. special .. " sin enfocarlo" })

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. plus,  hl.dsp.focus({ workspace = "+1" }), { desc = "Ir al siguente workspace" })
hl.bind(mainMod .. minus, hl.dsp.focus({ workspace = "-1" }), { desc = "Ir al anterior workspace" })

hl.bind(mainMod .. shift .. plus,  hl.dsp.window.move({ workspace = "+1" }), { desc = "Mover ventana al siguente workspace" })
hl.bind(mainMod .. shift .. minus, hl.dsp.window.move({ workspace = "-1" }), { desc = "Mover ventana al anterior workspace" })

hl.bind(mainMod .. ctrl .. plus,  hl.dsp.window.move({ workspace = "+1", follow = false }), { desc = "Mover ventana al siguente workspace sin enfocarlo" })
hl.bind(mainMod .. ctrl .. minus, hl.dsp.window.move({ workspace = "-1", follow = false }), { desc = "Mover ventana al anterior workspace sin enfocarlo" })
