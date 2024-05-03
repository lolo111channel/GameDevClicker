extends Node

func center_pivot_offset(size:Vector2) -> Vector2:
	return Vector2(size.x/2,size.y/2)

func tween_ui_scale_animation(object:Control,min : Vector2, max : Vector2 ,duration : float) -> void:
	var tween : Tween = create_tween()
	tween.tween_property(object,"scale",min,duration)
	tween.tween_property(object,"scale",max,duration)
