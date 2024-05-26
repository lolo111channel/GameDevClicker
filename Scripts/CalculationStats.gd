class_name CalculationStats extends Node2D

@export var player : Player
@export var workers : Workers
@export var marketing : Marketing


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
	
	var how_many_fans_get : int = how_many_games_made * player.making_current_game_clone.sizes_of_game[player.current_index_of_size_of_game].add_min_fans
	if marketing:
		marketing.add_fans(how_many_fans_get)
