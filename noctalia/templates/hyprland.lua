local primary = "rgba({{colors.primary.default.hex_stripped}}ee)"
local surface = "rgba({{colors.surface.default.hex_stripped}}aa)"
local secondary = "rgba({{colors.secondary.default.hex_stripped}}ee)"
local error = "rgba({{colors.error.default.hex_stripped}}ee)"
local tertiary = "rgba({{colors.tertiary.default.hex_stripped}}ee)"
local surface_lowest = "rgba({{colors.surface_container_lowest.default.hex_stripped}}aa)"

hl. config ({
    general = {
        col = {
            active_border = primary,
            inactive_border = surface,
        },

    },

    decoration = {
        shadow = {
            color = surface,
            color_inactive = surface,
        },

        glow = {
            color = surface,
            color_inactive = surface,
        },
    },
    group = {
        col = {
            border_active = secondary,
            border_inactive = surface,
            border_locked_active = error,
            border_locked_inactive = surface,
        },

        groupbar = {
            col = {
                active = secondary,
                inactive = surface,
                locked_active = error,
                locked_inactive = surface,
            },
        },
    },
})
