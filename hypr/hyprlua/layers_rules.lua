 local function noctalia_v5()
    if os.getenv("USER") == "alex" then

        hl.layer_rule {
            name         = "noctalia-bar",
            match        = { namespace = "noctalia-bar-.*$" },
            ignore_alpha = 0.5,
            blur         = true,
            blur_popups  = true,
        }

        hl.layer_rule {
            name         = "noctalia-panel",
            match        = { namespace = "noctalia-panel" },
            ignore_alpha = 0.5,
            blur         = true,
            blur_popups  = true,
        }

        hl.layer_rule {
            name         = "noctalia-screen-corner",
            match        = { namespace = "noctalia-screen-corner" },
            ignore_alpha = 0.5,
            blur         = true,
            blur_popups  = true,
        }

        hl.layer_rule {
            name         = "noctalia-osd",
            match        = { namespace = "noctalia-osd" },
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
