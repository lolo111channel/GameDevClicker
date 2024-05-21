extends PanelContainer

@export var text : String = ""
var hint_ui : Hint

var mouse_enter : bool = false

func _ready() -> void:
	hint_ui = get_tree().get_first_node_in_group("HintUI")
	

func _process(delta) -> void:
	if mouse_enter:
		if hint_ui:
			hint_ui.set_hint(text,get_global_mouse_position())

func _on_mouse_entered():
	mouse_enter = true


func _on_mouse_exited():
	if hint_ui:
		hint_ui.position = Vector2(10000,10000)
	mouse_enter = false
