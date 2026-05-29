----------------------
---- WINDOW RULES ----
----------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

local suppressMaximizeRule = hl.window_rule({
  -- Ignore maximize requests from all apps. You'll probably like this.
  name           = "suppress-maximize-events",
  match          = { class = ".*" },

  suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(true)

hl.window_rule({
  name     = "fix-xwayland-drags",
  match    = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})

hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move  = "20 monitor_h-120",
  float = true,
})

hl.window_rule({
  name  = "hyprland-share-picker",
  match = {
    class = "hyprland-share-picker",
    title = "Select what to share",
  },
  float = true,
  size  = { "(monitor_w/3)", "(monitor_h/2)" },
})

hl.window_rule({
  name  = "xdg-desktop-portal-gtk-float",
  match = { class = "xdg-desktop-portal-gtk" },
  float = true,
})

hl.window_rule({
  name  = "Inkscape-float",
  match = {
    class = "org.inkscape.Inkscape",
    title = "jpeg importación de imagen de mapa de bits",
  },
  float = true,
})

hl.window_rule({
  name   = "pip-video",
  match  = {
    class = "^firefox$|^$",
    title = "^Picture-in-Picture$|^Pantalla en pantalla$",
  },
  float  = true,
  pin    = true,
  opaque = true,
  size   = { "(monitor_w*0.3)", "(monitor_h*0.3)" },
  move   = { "((monitor_w*0.7)-10)", 40 },
})

hl.window_rule({
  name   = "telegram-video",
  match  = {
    class = "^org.telegram.desktop$",
    title = "^Visor multimedia$",
  },
  float  = true,
  pin    = true,
  opaque = true,
  size   = { 498, 378 },
  move   = { "(monitor_w-508)", 40 },
})

hl.window_rule({
  name        = "piner",
  match       = {
    pin = true,
  },
  border_size = 1,
})
