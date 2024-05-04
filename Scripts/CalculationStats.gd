class_name CalculationStats extends Node2D

@export var player : Player
@export var workers : Workers

func calculation_stats(seconds) -> void:
	var points : Dictionary = workers.get_workers_points()
	var how_many_games_made : float = seconds * player.get_game_per_second(points)
	player.add_money(player.making_current_game_clone.min_earnings * round(how_many_games_made))
	player.created_games.append({
		name = "Your company made %s games " % [round(how_many_games_made)],
		money_earned = player.making_current_game_clone.min_earnings * how_many_games_made
	})
	
	player.add_created_games(round(how_many_games_made))
