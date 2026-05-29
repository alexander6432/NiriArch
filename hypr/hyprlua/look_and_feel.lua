-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
  general = {
    gaps_in                 = 4,
    gaps_out                = 8,
    float_gaps              = 8,
    gaps_workspaces         = 4,

    border_size             = 3,

    col                     = {
      active_border   = {
        colors = {
          "rgba(33ccffee)",
          "rgba(00ff99ee)",
        },
        angle = 45
      },
      inactive_border = "rgba(595959aa)",
    },

    resize_on_border        = true,
    no_focus_fallback       = true,
    extend_border_grab_area = 8,
    hover_icon_on_border    = true,
    resize_corner           = 0,


    -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
    allow_tearing         = false,
    modal_parent_blocking = true,


    layout = "dwindle",
    locale = "es",

    snap = {
      enabled        = true,
      window_gap     = 8,
      monitor_gap    = 8,
      border_overlap = true,
      respect_gaps   = true,
    }

  },

  decoration = {
    rounding              = 8,
    rounding_power        = 4.0,

    active_opacity        = 1.0,
    inactive_opacity      = 0.9,
    fullscreen_opacity    = 1.0,

    dim_modal             = true,
    dim_inactive          = true,
    dim_strength          = 0.2,
    dim_special           = 0.4,
    dim_around            = 0.4,

    border_part_of_window = true,

    shadow                = {
      enabled        = true,
      range          = 4,
      render_power   = 2,
      sharp          = false,
      color          = "rgba(1a1a1aee)",
      color_inactive = "rgba(1a1a1aee)",
      offset         = { 0, 0 },
      scale          = 1.0,
    },

    blur                  = {
      enabled                   = true,
      size                      = 4,
      passes                    = 2,
      ignore_opacity            = true,
      xray                      = false,

      noise                     = 0.02,
      contrast                  = 0.9,
      brightness                = 0.8,
      vibrancy                  = 0.2,
      vibrancy_darkness         = 0.4,

      special                   = false,
      popups                    = true,
      popups_ignorealpha        = 0.25,
      input_methods             = true,
      input_methods_ignorealpha = 0.25,

    },

    glow                  = {
      enabled        = true,
      range          = 4,
      render_power   = 2,
      color          = "rgba(1a1a1aee)",
      color_inactive = "rgba(1a1a1aee)",
    }
  },
})
