extends AudioStreamPlayer


func _ready() -> void:
	if get_parent().has_signal("pressed"):
		get_parent().pressed.connect(_pressed)
		
func _pressed() -> void:
	if !playing:
		play()
