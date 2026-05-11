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
require("hyprlua.environmentVariables")
require("hyprlua.permissions")
require("hyprlua.lookAndFeel")
require("hyprlua.layouts")
require("hyprlua.misc")
require("hyprlua.input")
require("hyprlua.windowAndWorkspace")

require("hyprlua.keybindings.functions")
require("hyprlua.keybindings.layoutDwindle")
require("hyprlua.keybindings.miscellaneous")
require("hyprlua.keybindings.windows")
require("hyprlua.keybindings.workspaces")
