class_name Hint extends PanelContainer

var hint : String = ""
var current_object

func _process(delta) -> void:
	$Label.text = hint


func set_hint(value : String, pos : Vector2) -> void:
	hint = value
	position = pos

func set_current_object(object : Control) -> void:
	current_object = object
