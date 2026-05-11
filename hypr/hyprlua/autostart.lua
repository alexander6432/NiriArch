-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function ()
  hl.exec_cmd("qs -c noctalia-shell")
  hl.exec_cmd("~/.config/scripts/alert_battery.sh")
  hl.exec_cmd("~/.config/scripts/setup_portals_hyprland.sh")
end)
