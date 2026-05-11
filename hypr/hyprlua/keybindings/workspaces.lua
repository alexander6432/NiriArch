---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift   = "SHIFT + "
local ctrl    = "CTRL + "

local special = "Apostrophe"

local plus = "period"
local minus = "comma"

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. shift .. key,     hl.dsp.window.move({ workspace = i }))
    hl.bind(mainMod .. ctrl .. key,     hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. special,         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. shift .. special, hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. ctrl .. special, hl.dsp.window.move({ workspace = "special:magic", follow = false }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. plus, hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. minus,   hl.dsp.focus({ workspace = "-1" }))

hl.bind(mainMod .. shift .. plus,     hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mainMod .. shift .. minus,     hl.dsp.window.move({ workspace = "-1" }))

hl.bind(mainMod .. ctrl .. plus,     hl.dsp.window.move({ workspace = "+1", follow = false }))
hl.bind(mainMod .. ctrl .. minus,     hl.dsp.window.move({ workspace = "-1", follow = false }))
