class_name CalculationStats extends Node2D

@export var player : Player
@export var workers : Workers

func calculation_stats(seconds) -> void:
	var points : int = workers.get_workers_points()
	var how_many_games_made : float = seconds * player.get_game_per_second(points)
	
	var how_many_earned : int = player.making_current_game_clone.min_earnings * round(how_many_games_made)
	if how_many_earned > 0:
		player.add_money(how_many_earned)
		
		player.created_games.append({
			name = "Your company made %s games " % [round(how_many_games_made)],
			money_earned = how_many_earned
		})
		
		player.add_created_games(round(how_many_games_made))
