--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Ref https://wiki.hypr.land/Configuing/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
suppressMaximizeRule:set_enabled(true)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule ({
    name = "hyprland-share-picker",
    match = {
        class = "hyprland-share-picker",
        title = "Select what to share",
    },
    float = true,
    size = {"(monitor_w/3)", "(monitor_h/2)"},
})

hl.window_rule ({
    name = "xdg-desktop-portal-gtk-float",
    match = { class = "xdg-desktop-portal-gtk"},
    float = true,
})

hl.window_rule ({
    name = "Inkscape-float",
    match = {
        class = "org.inkscape.Inkscape",
        title = "jpeg importación de imagen de mapa de bits",
    },
    float = true,
})

hl.window_rule ({
    name = "pip-video",
    match = {
        class = "^firefox$|^$",
        title = "^Picture-in-Picture$|^Pantalla en pantalla$",
    },
    float = true,
    pin = true,
    opaque = true,
    size = {"(monitor_w*0.3)", "(monitor_h*0.3)"},
    move = {"((monitor_w*0.7)-10)", 40},
})

hl.window_rule ({
    name = "telegram-video",
    match = {
        class = "^org.telegram.desktop$",
        title = "^Visor multimedia$",
    },
    float = true,
    pin = true,
    opaque = true,
    size = {498, 378},
    move = {"(monitor_w-508)", 40},
})

hl.layer_rule {
  name = "noctalia",
  match = { namespace = "noctalia-background-.*$"},
  ignore_alpha = 0.5,
  blur = true,
  blur_popups = true,
}
