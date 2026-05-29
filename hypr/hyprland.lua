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
require("hyprlua.keybindings.windows")
require("hyprlua.keybindings.windows_state")
require("hyprlua.keybindings.workspaces")

require("hyprlua.keybindings.layouts.dwindle").setup()
require("hyprlua.keybindings.layouts.master").setup()
require("hyprlua.keybindings.layouts.monocle").setup()
require("hyprlua.keybindings.layouts.scrolling").setup()

-- noctalia
local function noctalia_v5()
  if os.getenv("USER") == "alex" then
    require("hyprlua.keybindings.functions_n5")
    require("hyprlua.keybindings.noctalia_v5")
  else
    require("hyprlua.keybindings.functions")
    require("hyprlua.keybindings.noctalia_v4")
  end
end

noctalia_v5()

local home = os.getenv("HOME")
local file_dir = "/.config/hypr/noctalia.lua"

if os.rename(home .. file_dir, home .. file_dir) ~= nil then
  require("noctalia")
end
