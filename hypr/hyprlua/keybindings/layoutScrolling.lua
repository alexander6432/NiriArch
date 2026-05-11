---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift = "SHIFT + "
local ctrl = "CTRL + "

hl.bind(mainMod .. "R", hl.dsp.layout("colresize -conf"))
hl.bind(mainMod .. shift + "R", hl.dsp.layout("colresize +conf"))

hl.bind(mainMod .. "plus", hl.dsp.layout("colresize +0.05"))
hl.bind(mainMod .. "minus", hl.dsp.layout("colresize -0.05"))

hl.bind(mainMod .. "A", hl.dsp.layout("fit visible"))
hl.bind(mainMod .. "S", hl.dsp.layout("fit all"))

hl.bind(mainMod .. "L", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. "H", hl.dsp.layout("swapcol r"))

hl.bind(mainMod .. "I", hl.dsp.layout("promote"))
hl.bind(mainMod .. shift .. "I", hl.dsp.layout("expel"))
hl.bind(mainMod .. ctrl .. "I", hl.dsp.layout("consume"))

hl.bind(mainMod .. shift .. "A", hl.dsp.layout("consume_or_expel prev"))
hl.bind(mainMod .. shift .. "S", hl.dsp.layout("consume_or_expel next"))
