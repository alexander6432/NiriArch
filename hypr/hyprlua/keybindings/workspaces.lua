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

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. key,          hl.dsp.focus({ workspace = i}),                        { desc = "Ir al workspace " .. key })
    hl.bind(mainMod .. shift .. key, hl.dsp.window.move({ workspace = i }),                 { desc = "Mover ventana al workspace " .. key })
    hl.bind(mainMod .. ctrl ..  key, hl.dsp.window.move({ workspace = i, follow = false }), { desc = "Mover ventana al workspace " .. key .. " sin enfocarlo" })
end

hl.bind(mainMod .. special_key,          hl.dsp.workspace.toggle_special(special),                                  { desc = "Ir al workspace especial: " .. special })
hl.bind(mainMod .. shift .. special_key, hl.dsp.window.move({ workspace = "special:" .. special }),                 { desc = "Mover ventana al workspace especial: " .. special })
hl.bind(mainMod .. ctrl ..  special_key, hl.dsp.window.move({ workspace = "special:" .. special, follow = false }), { desc = "Mover ventana al workspace especial: " .. special .. " sin enfocarlo" })

hl.bind(mainMod .. plus, function()
    local wa = hl.get_active_workspace()
    if not wa then return end
    if wa.windows > 0 and wa.id ~= 10 then
        hl.dispatch(hl.dsp.focus({ workspace = "+1" }))
    else
        hl.dispatch(hl.dsp.focus({ workspace = "e+1" }))
    end
end,
{ desc = "Ir al siguiente workspace" })

hl.bind(mainMod .. minus, function()
    local wa = hl.get_active_workspace()
    if not wa then return end
    if wa.windows > 0 and wa.id ~= 1 then
        hl.dispatch(hl.dsp.focus({ workspace = "-1" }))
    else
        hl.dispatch(hl.dsp.focus({ workspace = "e-1" }))
    end
end,
{ desc = "Ir al anterior workspace" })

hl.bind(mainMod .. shift .. plus, function()
    local w = hl.get_active_workspace()
    if not w then return end
    if w.id < 10 then
        hl.dispatch(hl.dsp.window.move({ workspace = "+1" }))
    else
        hl.dispatch(hl.dsp.window.move({ workspace = "1" }))
    end
end,
{ desc = "Mover ventana al siguiente workspace" })

hl.bind(mainMod .. shift .. minus, function()
    local w = hl.get_active_workspace()
    if not w then return end
    if w.id > 1 then
        hl.dispatch(hl.dsp.window.move({ workspace = "-1" }))
    else
        hl.dispatch(hl.dsp.window.move({ workspace = "10" }))
    end
end,
{ desc = "Mover ventana al anterior workspace" })

hl.bind(mainMod .. ctrl .. plus, function()
    local w = hl.get_active_workspace()
    if not w then return end
    if w.id < 10 then
        hl.dispatch(hl.dsp.window.move({ workspace = "+1", follow = false }))
    else
        hl.dispatch(hl.dsp.window.move({ workspace = "1",  follow = false }))
    end
end,
{ desc = "Mover ventana al siguiente workspace sin enfocarlo" })

hl.bind(mainMod .. ctrl .. minus, function()
    local w = hl.get_active_workspace()
    if not w then return end
    if w.id > 1 then
        hl.dispatch(hl.dsp.window.move({ workspace = "-1", follow = false }))
    else
        hl.dispatch(hl.dsp.window.move({ workspace = "10", follow = false }))
    end
end,
{ desc = "Mover ventana al anterior workspace sin enfocarlo" })
