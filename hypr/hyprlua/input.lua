---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "es",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = false,
            scroll_factor = 1.0,
            tap_to_click = true,
        },
    },

    gestures = {
        workspace_swipe_distance = 250,
        workspace_swipe_invert = true,
        workspace_swipe_min_speed_to_force = 50,
        workspace_swipe_cancel_ratio = 0.25,
        workspace_swipe_create_new = true,
        workspace_swipe_direction_lock = true,
        workspace_swipe_direction_lock_threshold = 8,
        workspace_swipe_forever = false,
        workspace_swipe_use_r = false,
        close_max_timeout = 800,
    }
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.gesture({
    fingers = 3,
    direction = "vertical",
    action = "float"
})


-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})
