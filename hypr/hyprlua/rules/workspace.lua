-------------------------
---- WORKSPACE RULES ----
-------------------------

local colors = require("noctalia").colors

-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.window_rule({
	name = "master",
	match = {
		workspace = "name:master",
	},
	border_color = colors.secondary,
})

hl.window_rule({
	name = "monocle",
	match = {
		workspace = "name:monocle",
	},
	border_color = colors.error,
})

hl.window_rule({
	name = "scrolling",
	match = {
		workspace = "name:scrolling",
	},
	border_color = {
		colors = {
			colors.primary,
			colors.secondary,
		},
		angle = 45,
	},
})
