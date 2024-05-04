class_name Game extends Node2D

var game_name : String = "Game" 
var min_earnings : int = 50
var max_earnings : int = 100

var sizes_of_game : Array[Dictionary] =[
	{
		name = "Mini Game",
		required_points = {
			development_progress = 10
		},
		workers_needed = 0,
		min_earnings = 50,
		max_earnings = 100
	},
	{
		name = "Indie Game",
		required_points = {
			development_progress = 50
		},
		workers_needed = 5,
		min_earnings = 500,
		max_earnings = 1000
	},
	{
		name = "Big Indie Game",
		required_points = {
			development_progress = 100
		},
		workers_needed = 20,
		min_earnings = 1000,
		max_earnings = 4000,
	},
	{
		name = "AA",
		required_points = {
			development_progress = 500
		},
		workers_needed = 85,
		min_earnings = 10000,
		max_earnings = 15000,
	},
	{
		name = "AAA",
		required_points = {
			development_progress = 1000
		},
		workers_needed = 200,
		min_earnings = 100000,
		max_earnings = 200000,
	},
	{
		name = "AAAA",
		required_points = {
			development_progress = 10000
		},
		workers_needed = 1000,
		min_earnings = 1000000,
		max_earnings = 5000000,
	}
]

var current_size_of_game : Dictionary = {
	
}

var required_points : Dictionary = {
	development_progress = 10
}

var current_points : Dictionary = {
	development_progress = 0
}

func _ready() -> void:
	set_current_size_of_game(0)

func add_points(points : Dictionary) -> void:
	if current_points != required_points:
		if current_points.development_progress < required_points.development_progress:
			current_points.development_progress += points.development_progress
			current_points.development_progress = clamp(current_points.development_progress,0,required_points.development_progress)
		

func is_finished_game() -> bool:
	if current_points == required_points:
		return true
		
	return false


func get_stats() -> Dictionary:
	return {
		name = game_name,
		
		max_development_progress = required_points.development_progress,
		development_progress = current_points.development_progress,

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


func get_size_of_game(id : int) -> Dictionary:
	return sizes_of_game[id]

func set_current_size_of_game(id : int) -> void:
	current_size_of_game = get_size_of_game(id)
	required_points = current_size_of_game.required_points
	min_earnings = current_size_of_game.min_earnings
	max_earnings = current_size_of_game.max_earnings
