extends PanelContainer

var review_index : int = 0
var review : Dictionary
var reviews : Reviews

var review_text : String = ""

func _ready() -> void:
	get_node("Label").text = review_text
	
	var hint : String = "Click to get effect"
	var positive_effect_chance_str : String = "Positive Effect %s" % [str(review.positive_effect.chance) + "%"]
	var positive_effect_duration_str : String = "Duration: %s" % [str(review.positive_effect.duration) + "s"]
	var positive_effect_add_money_str : String = "Increase earning: %s" % [snappedf(review.positive_effect.add_money,0.01)]
	var positive_effect_add_fans_str : String = "Increase fans: %s" % [snappedf(review.positive_effect.add_fans,0.01)]
	var positive_effect_game_production_str : String = "Shorten production game: %s" % [snappedf(review.positive_effect.game_production,0.01)]
	
	var negative_effect_change_str : String = "Negative Effect %s" % [str(review.negative_effect.chance) + "%"]
	var negative_effect_duration_str : String = "Duration: %s" % [str(review.negative_effect.duration) + "s"]
	var negative_effect_add_money_str : String = "Decrease earning: %s" % [snappedf(review.negative_effect.add_money,0.01)]
	var negative_effect_add_fans_str : String = "Decrease fans: %s" % [snappedf(review.negative_effect.add_fans,0.01)]
	var negative_effect_game_production_str : String = "Game production extended: %s" % [snappedf(review.negative_effect.game_production,0.01)]
	
	$ClickablePanel.hint = "%s\n\n%s\n%s\n%s\n%s\n%s\n\n%s\n%s\n%s\n%s\n%s" % [
		hint,
		positive_effect_chance_str,
		positive_effect_duration_str,
		positive_effect_add_money_str,
		positive_effect_add_fans_str,
		positive_effect_game_production_str,
		negative_effect_change_str,
		negative_effect_duration_str,
		negative_effect_add_money_str,
		negative_effect_add_fans_str,
		negative_effect_game_production_str
	]

func _on_clickable_panel_pressed():
	pivot_offset = Global.center_pivot_offset(size)
	Global.tween_ui_scale_animation(self,Vector2(0.8,0.8),Vector2(1.0,1.0),0.2)
	
	if reviews:
		reviews.select_review(review_index)
		
