class_name Game extends Node2D

var game_name : String = "Game" 
var min_earnings : int = 5
var max_earnings : int = 100

var required_points : Dictionary = {
	design = 10,
	art = 10,
	programming = 10
}

var current_points : Dictionary = {
	design = 0,
	art = 0,
	programming = 0
}


func add_points(points : Dictionary) -> void:
	if current_points != required_points:
		current_points.design += points.design
		current_points.art += points.art
		current_points.programming += points.programming

func is_finished_game() -> bool:
	if current_points == required_points:
		return true
		
	return false


func get_stats() -> Dictionary:
	return {
		name = game_name,
		
		max_design = required_points.design,
		design = current_points.design,
		
		max_programming = required_points.programming,
		programming = current_points.programming,
		
		max_art = required_points.art,
		art = current_points.art,
	}

func finish_game() -> Dictionary:
	queue_free()
	
	var rng : RandomNumberGenerator = RandomNumberGenerator.new()
	rng.randomize()
	var money_earned = rng.randi_range(min_earnings,max_earnings)
	
	return {
		name = game_name,
		points = required_points,
		money_earned = money_earned
	}
