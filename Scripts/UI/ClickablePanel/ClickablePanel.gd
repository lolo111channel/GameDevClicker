class_name ClickablePanel extends Panel

@export var hint : String = "S"
@export var can_click : bool = true
var hint_ui : Hint
var mouse_enter : bool  = false

signal pressed

func _ready() -> void:
	hint_ui = get_tree().get_first_node_in_group("HintUI")

func _process(delta) -> void:
	if mouse_enter:
		if hint_ui:
			if hint_ui.current_object == self:
				hint_ui.set_hint(hint,get_global_mouse_position())
			else:
				mouse_enter = false
	
func _on_gui_input(event):
	if event is InputEventScreenTouch and can_click:
		if event.pressed:
			_on_mouse_exited()
			emit_signal("pressed")
			



func _on_mouse_entered():
	$Timer.start(0.75)


func _on_mouse_exited():
	if hint_ui:
		hint_ui.position = Vector2(10000000,1000)
	mouse_enter = false
	$Timer.stop()


func _on_timer_timeout():
	if hint_ui:
		hint_ui.set_current_object(self)
	mouse_enter = true
