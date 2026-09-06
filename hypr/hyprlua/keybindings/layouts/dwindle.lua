------------------------
---- LAYOUT DWINDLE ----
------------------------

local M = {}

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift = "SHIFT + "

local function on_dwindle(dispatcher)
	return function()
		local wa = hl.get_active_workspace()
		if wa and wa.tiled_layout == "dwindle" then
			hl.dispatch(hl.dsp.layout(dispatcher))
		end
	end
end

function M.setup()
	hl.bind(mainMod .. "Tab", on_dwindle("rotatesplit 90"), { desc = "Rotar la división en sentido horario[dwindle]" })
	hl.bind(
		mainMod .. shift .. "Tab",
		on_dwindle("rotatesplit -90"),
		{ desc = "Rotar la división en sentido antihorario[dwindle]" }
	)

	hl.bind(mainMod .. "A", on_dwindle("swapsplit"), { desc = "Intercambiar división[dwindle]" })

	hl.bind(mainMod .. "S", on_dwindle("movetoroot unstable"), { desc = "Intercambiar división[dwindle]" })
	hl.bind(
		mainMod .. shift .. "S",
		on_dwindle("movetoroot active unstable"),
		{ desc = "Intercambiar división[dwindle]" }
	)

	hl.bind(mainMod .. "Plus", on_dwindle("splitratio +0.05"), { desc = "Aumentar relación de la división[dwindle]" })
	hl.bind(mainMod .. "Minus", on_dwindle("splitratio -0.05"), { desc = "Reducir relación de la división[dwindle]" })

	hl.bind(mainMod .. "H", on_dwindle("preselect l"), { desc = "Izquierda para la siguiente ventana[dwindle]" })
	hl.bind(mainMod .. "L", on_dwindle("preselect r"), { desc = "Derecha para la siguiente ventana[dwindle]" })
	hl.bind(mainMod .. "K", on_dwindle("preselect u"), { desc = "Arriba para la siguiente ventana[dwindle]" })
	hl.bind(mainMod .. "J", on_dwindle("preselect d"), { desc = "Abajo para la siguiente ventana[dwindle]" })
end

return M
