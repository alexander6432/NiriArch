---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift = "SHIFT + "

hl.bind(mainMod .. "Tab", hl.dsp.layout("cyclenext"))
hl.bind(mainMod .. shift .. "Tab", hl.dsp.layout("cycleprev"))
