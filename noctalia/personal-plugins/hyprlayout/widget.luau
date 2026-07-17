local layouts = {
  dwindle   = "D",
  master    = "M",
  monocle   = "U",
  scrolling = "S",
}

function update()
  noctalia.setUpdateInterval(500)
  -- barWidget.setGlyph("puzzle")

  noctalia.runAsync("hyprctl activeworkspace -j", function(result)
    if result.exitCode ~= 0 then
      barWidget.setText("?")
      return
    end

    local data = noctalia.json.decode(result.stdout)
    if not data then
      barWidget.setText("?")
      return
    end

    local layout = data.tiledLayout
    barWidget.setText(layouts[layout] or layout or "?")
  end)
end
