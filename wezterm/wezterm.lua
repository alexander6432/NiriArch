local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

config.default_prog = { "fish" }
config.quick_select_alphabet = "1234567890asdfghjklqwertyuiopzxcvbnm"

config.window_background_opacity = 0.75

config.font_size = 10
config.font = wezterm.font({
	family = "JetBrainsMono Nerd Font",
})

config.color_scheme = "Noctalia"

config.hide_tab_bar_if_only_one_tab = false
config.disable_default_key_bindings = true

wezterm.on("update-right-status", function(window, pane)
	local name = window:active_key_table()
	if name then
		name = "Modo: " .. name .. "  "
	end
	window:set_right_status(name or "")
end)

-- config.leader = { key = "Space", mods = "CTRL|SHIFT" }

config.keys = {
	{
		key = "s",
		mods = "CTRL|SHIFT",
		action = act.ActivateKeyTable({
			name = "splits",
			one_shot = false,
			timeout_milliseconds = 10000,
		}),
	},

	{
		key = "t",
		mods = "CTRL|SHIFT",
		action = act.ActivateKeyTable({
			name = "tabs",
			one_shot = true,
			timeout_milliseconds = 10000,
		}),
	},

	{
		key = "F1",
		mods = "CTRL",
		action = act.ActivateCommandPalette,
	},

	{
		key = "c",
		mods = "CTRL|SHIFT",
		action = act.CopyTo("Clipboard"),
	},

	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = act.PasteFrom("Clipboard"),
	},

	{
		key = "r",
		mods = "CTRL|SHIFT",
		action = act.ReloadConfiguration,
	},
}

config.key_tables = {
	splits = {
		{ key = "h", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "v", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "H", action = act.SplitPane({ direction = "Left" }) },
		{ key = "V", action = act.SplitPane({ direction = "Up" }) },

		{ key = "f", action = act.PaneSelect({ mode = "Activate" }) },
		{ key = "s", action = act.PaneSelect({ mode = "SwapWithActiveKeepFocus" }) },
		{ key = "t", action = act.PaneSelect({ mode = "MoveToNewTab" }) },
		{ key = "w", action = act.PaneSelect({ mode = "MoveToNewWindow" }) },

		{ key = "c", action = act.CloseCurrentPane({ confirm = true }) },
		{ key = "z", action = act.TogglePaneZoomState },

		{ key = "LeftArrow", mods = "SHIFT", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "RightArrow", mods = "SHIFT", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "UpArrow", mods = "SHIFT", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "DownArrow", mods = "SHIFT", action = act.AdjustPaneSize({ "Down", 1 }) },

		{ key = "LeftArrow", action = act.ActivatePaneDirection("Left") },
		{ key = "RightArrow", action = act.ActivatePaneDirection("Right") },
		{ key = "UpArrow", action = act.ActivatePaneDirection("Up") },
		{ key = "DownArrow", action = act.ActivatePaneDirection("Down") },
		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},

	tabs = {
		{ key = "t", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "T", action = act.SpawnTab("DefaultDomain") },
		{ key = "c", action = act.CloseCurrentTab({ confirm = true }) },
		{ key = "n", action = act.ActivateTabRelative(1) },
		{ key = "p", action = act.ActivateTabRelative(-1) },
		{ key = "N", action = act.MoveTabRelative(1) },
		{ key = "P", action = act.MoveTabRelative(-1) },
		{ key = "l", action = act.ShowTabNavigator },
		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},
}

for i = 1, 9 do
	table.insert(config.key_tables.tabs, {
		key = tostring(i),
		action = act.ActivateTab(i - 1),
	})
end

return config
