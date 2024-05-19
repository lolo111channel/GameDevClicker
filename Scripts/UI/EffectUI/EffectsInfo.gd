extends GridContainer

@export var effect_ui_scene : PackedScene
@export var player_ui : PlayerUI
var reviews : Reviews

func _ready() -> void:
	if player_ui:
		reviews = player_ui.get_reviews()
		reviews.selected_review.connect(_selected_review)
		
func _selected_review() -> void:
	for i in get_children():
		i.queue_free()
	
	for i in reviews.effects:
		var effect_ui = effect_ui_scene.instantiate()
		effect_ui.effect = i
		
		add_child(effect_ui)
