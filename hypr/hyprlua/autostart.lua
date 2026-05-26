-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

local noctalia = function ()
  if os.getenv("USER") == "alex" then
    return "noctalia -d"
  end
  return "qs -c noctalia-shell"

end

hl.on("hyprland.start", function ()
  hl.exec_cmd(noctalia())
  hl.exec_cmd("~/.config/scripts/alert_battery.sh")
  hl.exec_cmd("~/.config/scripts/setup_portals_hyprland.sh")
end)
