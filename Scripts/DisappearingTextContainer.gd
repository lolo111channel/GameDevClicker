class_name DisappearingTextContainer extends CanvasLayer

@export var disappearing_text_scene : PackedScene

func spawn_text(text : String,pos:Vector2) -> void:
	var disappearing_text : Label = disappearing_text_scene.instantiate()
	disappearing_text.text = text
	disappearing_text.global_position = pos
	
	add_child(disappearing_text)
