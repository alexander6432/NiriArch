---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift = "SHIFT + "
local ctrl = "CTRL + "

hl.bind(mainMod .. "A", hl.dsp.layout("cycleprev loop"))
hl.bind(mainMod .. "S", hl.dsp.layout("cyclenext loop"))

hl.bind(mainMod .. shift .. "A", hl.dsp.layout("swapprev loop"))
hl.bind(mainMod .. shift .. "S", hl.dsp.layout("swapnext loop"))

hl.bind(mainMod .. ctrl .. "A", hl.dsp.layout("rollprev"))
hl.bind(mainMod .. ctrl .. "S", hl.dsp.layout("rollnext"))

hl.bind(mainMod .. "I", hl.dsp.layout("swapwithmaster auto"))
hl.bind(mainMod .. "O", hl.dsp.layout("focusmaster auto"))

hl.bind(mainMod .. "plus", hl.dsp.layout("mfact +0.05"))
hl.bind(mainMod .. "minus", hl.dsp.layout("mfact -0.05"))

hl.bind(mainMod .. "R", hl.dsp.layout("removemaster"))
hl.bind(mainMod .. shift + "R", hl.dsp.layout("addmaster"))
