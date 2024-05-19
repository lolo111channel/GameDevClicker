extends PanelContainer

var review_index : int = 0
var review : Dictionary
var reviews : Reviews

var review_text : String = ""

func _ready() -> void:
	get_node("Label").text = review_text

func _on_clickable_panel_pressed():
	pivot_offset = Global.center_pivot_offset(size)
	Global.tween_ui_scale_animation(self,Vector2(0.8,0.8),Vector2(1.0,1.0),0.2)
	
	if reviews:
		reviews.select_review(review_index)
		
