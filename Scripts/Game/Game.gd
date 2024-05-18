class_name Game extends Node2D

var game_name : String = "Game" 
var min_earnings : int = 50
var max_earnings : int = 100
var base_price : int = 5

var sizes_of_game : Array[Dictionary] =[
	{
		name = "Mini Game",
		max_development_progress = 10,
		workers_needed = 0,
		min_earnings = 50,
		max_earnings = 100,
		
		add_min_fans = 1,
		add_max_fans = 8,
	},
	{
		name = "Indie Game",
		max_development_progress = 50,
		workers_needed = 5,
		min_earnings = 500,
		max_earnings = 1000,
		
		add_min_fans = 20,
		add_max_fans = 80,
	},
	{
		name = "Big Indie Game",
		max_development_progress = 100,
		workers_needed = 20,
		min_earnings = 1000,
		max_earnings = 4000,
		
		add_min_fans = 100,
		add_max_fans = 120,
	},
	{
		name = "AA",
		max_development_progress = 500,
		workers_needed = 85,
		min_earnings = 10000,
		max_earnings = 15000,
		
		add_min_fans = 200,
		add_max_fans = 450,
	},
	{
		name = "AAA",
		max_development_progress = 1000,
		workers_needed = 200,
		min_earnings = 100000,
		max_earnings = 200000,
		
		add_min_fans = 500,
		add_max_fans = 1500,
	},
	{
		name = "AAAA",
		max_development_progress = 10000,
		workers_needed = 1000,
		min_earnings = 1000000,
		max_earnings = 5000000,
		
		add_min_fans = 4000,
		add_max_fans = 10000,
	}
]

var current_size_of_game : Dictionary = {
	
}

var max_development_progress : float = 10
var development_progress : float = 0

var marketing : Marketing

signal finished_game(game_info : Dictionary)


func _ready() -> void:
	set_current_size_of_game(0)
	
func add_development_progress(value : int) -> void:
	if development_progress < max_development_progress:
		development_progress += value
		

func is_finished_game() -> bool:
	if development_progress >= max_development_progress:
		return true
		
	return false


func get_stats() -> Dictionary:
	return {
		name = game_name,
		max_development_progress = max_development_progress,
		development_progress = development_progress,
	}

func finish_game() -> Dictionary:
	queue_free()
	
	var rng : RandomNumberGenerator = RandomNumberGenerator.new()
	rng.randomize()
	var money_earned = rng.randi_range(min_earnings,max_earnings)
	if marketing:
		money_earned += marketing.get_money_that_fans_give()
	
	var game_info : Dictionary = {
		name = game_name,
		max_development_progress = max_development_progress,
		money_earned = money_earned,
		base_price = base_price,
		size_of_game = current_size_of_game
	}
	
	emit_signal("finished_game",game_info)
	return game_info


func get_size_of_game(id : int) -> Dictionary:
	return sizes_of_game[id]

func set_current_size_of_game(id : int) -> void:
	current_size_of_game = get_size_of_game(id)
	max_development_progress = current_size_of_game.max_development_progress
	min_earnings = current_size_of_game.min_earnings
	max_earnings = current_size_of_game.max_earnings
