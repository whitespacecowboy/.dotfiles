hl.gesture({ fingers = 3, direction = "vertical", action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

hl.gesture({
  fingers = 3,
  direction = "pinch",
  action = function()
	  hl.exec_cmd("rofi -show drun")
  end
})
