class_name Player extends Node2D

var money : int = 0
var making_current_game : Game
var making_current_game_clone : Game = Game.new()

var created_games : Array[Dictionary] = [
	
]

var created_games_count : int = 0

var player_points = {
	design = 1,
	art = 1,
	programming = 1
}

var current_index_of_size_of_game : int = 0

func _ready() -> void:
	making_current_game_clone.set_current_size_of_game(current_index_of_size_of_game)
	add_child(making_current_game_clone)


func _process(delta) -> void:
	if !making_current_game:
		making_current_game = Game.new()
		making_current_game.game_name = "Game %s" % [created_games_count + 1]
		making_current_game_clone = making_current_game
		
		get_parent().add_child(making_current_game)
	
	if is_instance_valid(making_current_game):
		making_current_game.set_current_size_of_game(current_index_of_size_of_game)
	
	if making_current_game.is_finished_game():
		var made_game = making_current_game.finish_game()
		add_money(made_game.money_earned)
		add_created_games(1)
		
		created_games.append(made_game)
		
	
func add_money(value : int) -> void:
	money += value

func decrease_money(value : int) -> void:
	money -= value

func add_created_games(value : int) -> void:
	created_games_count += value

func making_game(points) -> void:
	if is_instance_valid(making_current_game):
		if !making_current_game.is_finished_game():
			making_current_game.add_points(points)
			return
			
		
func get_game_per_second(points) -> float:
	var points_arr : Array = [
		points.programming,
		points.design,
		points.art
	]
	var min_points = points_arr.min()
	if is_instance_valid(making_current_game_clone):
		return (min_points as float / making_current_game_clone.required_points.design as float)
	
	return 0.0
