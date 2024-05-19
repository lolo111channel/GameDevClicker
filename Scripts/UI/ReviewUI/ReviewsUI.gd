extends GridContainer

@export var review_ui_scene : PackedScene
@export var player_ui : PlayerUI

var reviews : Reviews
var reviews_texts = [
	
]

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	if player_ui:
		reviews = player_ui.get_reviews()
		reviews.new_reviews.connect(_new_reviews)
		reviews.selected_review.connect(_selected_review)
	
	var reviews_file : FileAccess = FileAccess.open("res://Content/Reviews/Reviews.json",FileAccess.READ)
	var json_parse = JSON.parse_string(reviews_file.get_as_text())
	reviews_texts = json_parse['reviews']
	
	
func _selected_review() -> void:
	for i in get_children():
		i.queue_free()

func _new_reviews() -> void:
	for i in reviews.reviews.size():
		var review_ui = review_ui_scene.instantiate()
		
		review_ui.review_index = i
		review_ui.review = reviews.reviews[i]
		review_ui.reviews = reviews
		
		rng.randomize()
		review_ui.review_text = reviews_texts[rng.randi_range(0,reviews_texts.size()-1)]
		
		add_child(review_ui)
		
