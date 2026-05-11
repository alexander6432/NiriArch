---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier

hl.bind(mainMod .. "A", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. "S", hl.dsp.layout("swapsplit"))

hl.bind(mainMod .. "plus", hl.dsp.layout("splitratio +0.05"))
hl.bind(mainMod .. "minus", hl.dsp.layout("splitratio -0.05"))

hl.bind(mainMod .. "H", hl.dsp.layout("preselect l"))
hl.bind(mainMod .. "L", hl.dsp.layout("preselect r"))
hl.bind(mainMod .. "K", hl.dsp.layout("preselect u"))
hl.bind(mainMod .. "J", hl.dsp.layout("preselect d"))
