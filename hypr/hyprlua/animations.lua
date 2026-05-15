--------------------
---- ANIMATIONS ----
--------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    animations = {
        enabled = true,
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}        } })
hl.curve("easeInCubic",    { type = "bezier", points = { {0.32, 0},    {0.67, 0}     } })
hl.curve("easeOutCubic",   { type = "bezier", points = { {0.33, 1},    {0.68, 1}     } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0},    {0.35, 1}     } })
hl.curve("easeInCirc",     { type = "bezier", points = { {0.55, 0},    {1, 0.45}     } })
hl.curve("easeOutCirc",    { type = "bezier", points = { {0, 0.55},    {0.45, 1}     } })
hl.curve("easeInOutCirc",  { type = "bezier", points = { {0.85, 0},    {0.15, 1}     } })
hl.curve("easeInBack",     { type = "bezier", points = { {0.36, 0},    {0.66, -0.56} } })
hl.curve("easeOutBack",    { type = "bezier", points = { {0.34, 1.56}, {0.64, 1}     } })
hl.curve("easeInOutBack",  { type = "bezier", points = { {0.68, -0.6}, {0.32, 1.6}   } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global",                          enabled = true,  speed = 10,  bezier = "linear" })

    -- styles: slide(top, bottom, left, right), popin(0-100%), gnomed
    hl.animation({ leaf = "windows",                     enabled = true,  speed = 4.0, spring = "easy",          style = "slide"})
        hl.animation({ leaf = "windowsIn",               enabled = true,  speed = 4.0, bezier = "easeOutCirc",   style = "slide bottom" })
        hl.animation({ leaf = "windowsOut",              enabled = true,  speed = 4.0, bezier = "easeInCirc",    style = "slide top" })
        hl.animation({ leaf = "windowsMove",             enabled = true,  speed = 4.0, bezier = "easeInOutCirc" })

    -- styles: slide(top, bottom, left, right), popin(0-100%), fade
    hl.animation({ leaf = "layers",                      enabled = true,  speed = 2.0, bezier = "easeInOutCirc", style = "slide" })
        hl.animation({ leaf = "layersIn",                enabled = true,  speed = 2.0, bezier = "easeOutCirc",   style = "slide bottom" })
        hl.animation({ leaf = "layersOut",               enabled = true,  speed = 2.0,  bezier = "easeInCirc",   style = "slide top" })

    hl.animation({ leaf = "fade",                        enabled = true,  speed = 2.0, bezier = "easeInOutCirc" })
        hl.animation({ leaf = "fadeIn",                  enabled = true,  speed = 2.0, bezier = "easeOutCirc" })
        hl.animation({ leaf = "fadeOut",                 enabled = true,  speed = 2.0, bezier = "easeInCirc" })
        hl.animation({ leaf = "fadeSwitch",              enabled = true,  speed = 2.0, bezier = "easeInOutCirc" })
        hl.animation({ leaf = "fadeShadow",              enabled = true,  speed = 2.0, bezier = "easeInOutCirc" })
        hl.animation({ leaf = "fadeDim",                 enabled = true,  speed = 2.0, bezier = "easeInOutCirc" })
        hl.animation({ leaf = "fadeLayers",              enabled = true,  speed = 2.0, bezier = "easeInOutCirc" })
            hl.animation({ leaf = "fadeLayersIn",        enabled = true,  speed = 2.0, bezier = "easeOutCirc" })
            hl.animation({ leaf = "fadeLayersOut",       enabled = true,  speed = 2.0, bezier = "easeInCirc" })
        hl.animation({ leaf = "fadePopups",              enabled = true,  speed = 2.0, bezier = "easeInOutCirc" })
            hl.animation({ leaf = "fadePopupsIn",        enabled = true,  speed = 2.0, bezier = "easeOutCirc" })
            hl.animation({ leaf = "fadePopupsOut",       enabled = true,  speed = 2.0, bezier = "easeInCirc" })
        hl.animation({ leaf = "fadeDpms",                enabled = true,  speed = 2.0, bezier = "easeInOutCirc" })

    hl.animation({ leaf = "border",                      enabled = true,  speed = 4.0, bezier = "easeInOutCirc" })
    hl.animation({ leaf = "borderangle",                 enabled = true,  speed = 60,  bezier = "easeInOutCirc", style = "once" })

    hl.animation({ leaf = "workspaces",                  enabled = true,  speed = 2.0, bezier = "easeInOutCirc", style = "slidefade 25%" })
        hl.animation({ leaf = "workspacesIn",            enabled = true,  speed = 2.0, bezier = "easeOutCirc",   style = "slidefade 25%" })
        hl.animation({ leaf = "workspacesOut",           enabled = true,  speed = 2.0, bezier = "easeInCirc",    style = "slidefade 25%" })
        hl.animation({ leaf = "specialWorkspace",        enabled = true,  speed = 2.0, bezier = "easeInOutCirc", style = "slidefadevert 25%" })
            hl.animation({ leaf = "specialWorkspaceIn",  enabled = true,  speed = 2.0, bezier = "easeOutCirc",   style = "slidefadevert 25%" })
            hl.animation({ leaf = "specialWorkspaceOut", enabled = true,  speed = 2.0, bezier = "easeInCirc",    style = "slidefadevert 25%" })

    hl.animation({ leaf = "zoomFactor",                  enabled = true,  speed = 4.0, bezier = "easeOutCirc" })
    hl.animation({ leaf = "monitorAdded",                enabled = true,  speed = 10,  bezier = "easeInOutCirc" })
