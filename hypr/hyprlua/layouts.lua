-----------------
---- LAYOUTS ----
-----------------

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        force_split           = 0,
        preserve_split        = true, -- You probably want this
        smart_split           = false,
        smart_resizing        = true,
        special_scale_factor  = 0.95,
        use_active_for_splits = true,
        default_split_ratio   = 1.0,
        split_bias            = 1,
        precise_mouse_move    = true,
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        allow_small_split             = true,
        special_scale_factor          = 0.95,
        mfact                         = 0.55,
        new_status                    = "inherit",
        new_on_top                    = true,
        new_on_active                 = "before",
        orientation                   = "left",
        slave_count_for_center_master = 2,
        center_master_fallback        = "left",
        smart_resizing                = true,
        drop_at_cursor                = true,
        always_keep_position          = false,
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
        column_width             = 0.6,
        focus_fit_method         = 1,
        follow_focus             = true,
        follow_min_visible       = 0.8,
        explicit_column_widths   = "0.2, 0.4, 0.6, 0.8",
        direction =              "right",
    },
})
