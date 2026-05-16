-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function ()
  hl.exec_cmd("qs -c noctalia-shell")
  hl.exec_cmd("~/.config/scripts/alert_battery.sh")
  hl.exec_cmd("~/.config/scripts/setup_portals_hyprland.sh")
end)
