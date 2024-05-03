class_name ClickablePanel extends Panel

signal pressed

func _on_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			emit_signal("pressed")
