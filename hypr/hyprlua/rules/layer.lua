---------------------
---- LAYER RULES ----
---------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

hl.layer_rule {
  name         = "noctalia-bar",
  match        = {
    namespace = "noctalia-(bar-.+|notification|dock|panel|osd|screen-corner)$"
  },
  ignore_alpha = 0.5,
  blur         = true,
  blur_popups  = true,
}
