---------------------
---- LAYER RULES ----
---------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

 local function noctalia_v5()
    if os.getenv("USER") == "alex" then

        hl.layer_rule {
            name         = "noctalia-bar",
            match        = {
                namespace = "noctalia-(bar-.+|notification|dock|panel|osd|screen-corner)$"
            },
            ignore_alpha = 0.5,
            blur         = true,
            blur_popups  = true,
        }

    else

        hl.layer_rule {
            name         = "noctalia",
            match        = { namespace = "noctalia-background-.*$" },
            ignore_alpha = 0.5,
            blur         = true,
            blur_popups  = true,
        }
    end

end

noctalia_v5()
