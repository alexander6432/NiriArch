local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

config.default_prog = { "fish" }
config.quick_select_alphabet = "1234567890asdfghjklqwertyuiopzxcvbnm"

config.window_background_opacity = 0.75
config.default_cursor_style = "BlinkingBar"
config.animation_fps = 8
config.cursor_blink_ease_in = "EaseIn"
config.cursor_blink_ease_out = "EaseOut"

config.font_size = 10
config.font = wezterm.font({
	family = "JetBrainsMono Nerd Font",
})

config.color_scheme = "Noctalia"

config.hide_tab_bar_if_only_one_tab = false
config.disable_default_key_bindings = true

wezterm.on("update-right-status", function(window, pane)
	local name = window:active_key_table()
	if name == "search_mode" then
		name = "Busqueda"
	end
	if name == "copy_mode" then
		name = "Copia"
	end
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
			name = "Splits",
			one_shot = false,
			timeout_milliseconds = 10000,
		}),
	},

	{
		key = "t",
		mods = "CTRL|SHIFT",
		action = act.ActivateKeyTable({
			name = "Tabs",
			one_shot = true,
			timeout_milliseconds = 10000,
		}),
	},

	{
		key = "f",
		mods = "SHIFT|CTRL",
		action = act.Search({ Regex = "" }),
	},

	{
		key = "x",
		mods = "SHIFT|CTRL",
		action = act.ActivateCopyMode,
	},

	{ key = " ", mods = "SHIFT|CTRL", action = act.QuickSelect },

	{
		key = "F1",
		mods = "CTRL",
		action = act.ActivateCommandPalette,
	},

	{
		key = "c",
		mods = "CTRL|SHIFT",
		action = act.CopyTo("ClipboardAndPrimarySelection"),
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
	Splits = {
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
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "q", action = "PopKeyTable" },
	},

	Tabs = {
		{ key = "t", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "T", action = act.SpawnTab("DefaultDomain") },
		{ key = "c", action = act.CloseCurrentTab({ confirm = true }) },
		{ key = "n", action = act.ActivateTabRelative(1) },
		{ key = "p", action = act.ActivateTabRelative(-1) },
		{ key = "N", action = act.MoveTabRelative(1) },
		{ key = "P", action = act.MoveTabRelative(-1) },
		{ key = "l", action = act.ShowTabNavigator },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "q", action = "PopKeyTable" },
	},

	search_mode = {
		{ key = "Enter", action = act.CopyMode("PriorMatch") },
		{ key = "UpArrow", action = act.CopyMode("PriorMatch") },
		{ key = "DownArrow", action = act.CopyMode("NextMatch") },
		{ key = "s", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
		{ key = "c", mods = "CTRL", action = act.CopyMode("ClearPattern") },
		{ key = "Escape", action = act.CopyMode("Close") },
		{ key = "q", action = act.CopyMode("Close") },
	},

	copy_mode = {
		{ key = "c", action = act.CopyMode("ClearSelectionMode") },
		{ key = "Enter", action = act.CopyMode("MoveToStartOfNextLine") },
		{ key = "l", action = act.CopyMode("MoveToEndOfLineContent") },
		{ key = "h", action = act.CopyMode("MoveToStartOfLine") },
		{ key = "s", action = act.CopyMode("MoveToStartOfLineContent") },
		{ key = "w", action = act.CopyMode("MoveForwardWord") },
		{ key = "e", action = act.CopyMode("MoveForwardWordEnd") },
		{ key = "b", action = act.CopyMode("MoveBackwardWord") },
		{ key = "u", action = act.CopyMode("MoveToViewportTop") },
		{ key = "d", action = act.CopyMode("MoveToViewportBottom") },
		{ key = "m", action = act.CopyMode("MoveToViewportMiddle") },
		{ key = "g", action = act.CopyMode("MoveToScrollbackTop") },
		{ key = "G", action = act.CopyMode("MoveToScrollbackBottom") },
		{ key = "k", action = act.CopyMode("PageUp") },
		{ key = "j", action = act.CopyMode("PageDown") },
		{ key = "d", mods = "CTRL", action = act.CopyMode({ MoveByPage = 0.5 }) },
		{ key = "u", mods = "CTRL", action = act.CopyMode({ MoveByPage = -0.5 }) },
		{ key = "o", action = act.CopyMode("MoveToSelectionOtherEnd") },
		{ key = "O", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
		{ key = "V", action = act.CopyMode({ SetSelectionMode = "Line" }) },
		{ key = "v", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
		{ key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },
		{ key = "LeftArrow", action = act.CopyMode("MoveLeft") },
		{ key = "RightArrow", action = act.CopyMode("MoveRight") },
		{ key = "UpArrow", action = act.CopyMode("MoveUp") },
		{ key = "DownArrow", action = act.CopyMode("MoveDown") },
		{ key = ",", action = act.CopyMode("JumpReverse") },
		{ key = ".", action = act.CopyMode("JumpAgain") },
		{ key = "f", action = act.CopyMode({ JumpForward = { prev_char = false } }) },
		{ key = "F", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
		{ key = "t", action = act.CopyMode({ JumpForward = { prev_char = true } }) },
		{ key = "T", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
		{
			key = "Escape",
			action = act.Multiple({
				{ CopyMode = "MoveToScrollbackBottom" },
				{ CopyMode = "Close" },
			}),
		},
		{
			key = "q",
			action = act.Multiple({
				{ CopyMode = "MoveToScrollbackBottom" },
				{ CopyMode = "Close" },
			}),
		},
		{
			key = "y",
			action = act.Multiple({
				{ CopyTo = "ClipboardAndPrimarySelection" },
				{ CopyMode = "MoveToScrollbackBottom" },
				{ CopyMode = "Close" },
			}),
		},
		{
			key = "Y",
			action = act.Multiple({
				{ CopyTo = "ClipboardAndPrimarySelection" },
				{ CopyMode = "ClearSelectionMode" },
			}),
		},
	},
}

for i = 1, 9 do
	table.insert(config.key_tables.Tabs, {
		key = tostring(i),
		action = act.ActivateTab(i - 1),
	})
end

return config
