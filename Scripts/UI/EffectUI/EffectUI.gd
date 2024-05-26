extends PanelContainer

var effect : Dictionary

func _process(delta) -> void:
	var effect_type : String = "Positive Effect"
	var duration : String  = "Duration: %s" % [str(effect.duration) + "s"]
	var add_money : String = "Increase earning: %s" % [snappedf(effect.add_money,0.01)]
	var add_fans : String = "Increase fans: %s" %  [snappedf(effect.add_fans,0.01)]
	var game_production : String = "Shorten production game: %s" % [snappedf(effect.game_production,0.01)]
	
	if effect.effect_type == "negative":
		effect_type = "Negative Effect"
		add_money = "Decrease earning: %s" % [snappedf(effect.add_money,0.01)]
		add_fans = "Decrease fans: %s" %  [snappedf(effect.add_fans,0.01)]
		game_production= "Game production extended %s" % [snappedf(effect.game_production,0.01)]
	
	$ClickablePanel.hint = "%s\n%s\n%s\n%s\n%s" % [
		effect_type,
		duration,
		add_money,
		add_fans,
		game_production
	]
