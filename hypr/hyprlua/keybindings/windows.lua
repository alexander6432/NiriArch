-----------------
---- WINDOWS ----
-----------------

local mainMod = "SUPER + " -- Sets "Windows" key as main modifier
local shift   = "SHIFT + "
local ctrl    = "CTRL + "
local alt    = "ALT + "

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. "left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. "right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. "up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. "down",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. shift .. "left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. shift .. "right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. shift .. "up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. shift .. "down",  hl.dsp.window.move({ direction = "down" }))

hl.bind(mainMod .. ctrl .. "left",  hl.dsp.window.move({ x = "-20", y = "0",   relative = true }))
hl.bind(mainMod .. ctrl .. "right", hl.dsp.window.move({ x = "20",  y = "0",   relative = true }))
hl.bind(mainMod .. ctrl .. "up",    hl.dsp.window.move({ x = "0",   y = "-20", relative = true }))
hl.bind(mainMod .. ctrl .. "down",  hl.dsp.window.move({ x = "0",   y = "20",  relative = true }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. "mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. alt .. "mouse:272", hl.dsp.window.resize(), { mouse = true })

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. "Q", hl.dsp.window.close())
hl.bind(mainMod .. shift .. "Q", hl.dsp.window.kill())

hl.bind(mainMod .. "M", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. shift .. "M", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. ctrl .. "M", hl.dsp.window.fullscreen_state({ internal = "0", client = "3", action = "toggle" }))

hl.bind(alt .. "Tab", hl.dsp.window.cycle_next())
hl.bind(alt .. shift .. "Tab", hl.dsp.window.cycle_next({ next = false }))
hl.bind(alt .. ctrl .. "Tab", hl.dsp.window.cycle_next({ floating = true}))

hl.bind(mainMod .. "U",  hl.dsp.focus({ last = true }))
hl.bind(mainMod .. shift .. "U",  hl.dsp.focus({ urgent_or_last = true }))

hl.bind(mainMod .. "F", function ()
  hl.dispatch(hl.dsp.window.float({action = "toggle"}))
  local monitor = hl.get_active_monitor()
  if not monitor then return end
  local height = monitor.height * 0.7
  local width = monitor.width * 0.7
  hl.dispatch(hl.dsp.window.resize({x = width, y = height}))
end)

hl.bind(mainMod .. shift .. "F", hl.dsp.window.pseudo({ action = "toggle" }))
hl.bind(mainMod .. "P", hl.dsp.window.pin())

hl.bind(mainMod .. "C", hl.dsp.window.center())
