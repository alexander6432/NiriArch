------------------
---- HYPRLAND ----
------------------

-- https://wiki.hypr.land/Configuring/Start/

require("hyprlua.monitors")
require("hyprlua.autostart")
require("hyprlua.environment_variables")
require("hyprlua.permissions")
require("hyprlua.look_and_feel")
require("hyprlua.animations")
require("hyprlua.layouts")
require("hyprlua.misc")
require("hyprlua.input")
require("hyprlua.rules.window")
require("hyprlua.rules.layer")
require("hyprlua.rules.workspace")

require("hyprlua.keybindings.miscellaneous")
require("hyprlua.keybindings.general")
require("hyprlua.keybindings.windows")
require("hyprlua.keybindings.workspaces")

require("hyprlua.keybindings.layouts.dwindle").setup()
require("hyprlua.keybindings.layouts.master").setup()
require("hyprlua.keybindings.layouts.monocle").setup()
require("hyprlua.keybindings.layouts.scrolling").setup()

require("hyprlua.keybindings.functions")
require("hyprlua.keybindings.noctalia_v5")

-- For Noctalia Color templates
require("noctalia").apply_theme()
