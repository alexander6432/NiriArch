-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")

require("hyprlua.monitors")
require("hyprlua.autostart")
require("hyprlua.environment_variables")
require("hyprlua.permissions")
require("hyprlua.look_and_feel")
require("hyprlua.animations")
require("hyprlua.layouts")
require("hyprlua.misc")
require("hyprlua.input")
require("hyprlua.window_and_workspace")

require("hyprlua.keybindings.functions")
require("hyprlua.keybindings.miscellaneous")
require("hyprlua.keybindings.noctalia_v4")
require("hyprlua.keybindings.windows")
require("hyprlua.keybindings.workspaces")

require("hyprlua.keybindings.layout_dwindle")
require("hyprlua.keybindings.layout_master")
require("hyprlua.keybindings.layout_monocle")
require("hyprlua.keybindings.layout_scrolling")

-- noctalia
require("noctalia")
