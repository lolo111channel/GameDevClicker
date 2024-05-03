class_name Player extends Node2D

var money : int = 100000
var making_current_game : Game
var created_games : Array[Dictionary] = [
	
]

var player_points = {
	design = 1,
	art = 1,
	programming = 1
}

var current_index_of_size_of_game : int = 0

func _process(delta) -> void:
	if !making_current_game:
		making_current_game = Game.new()
		making_current_game.game_name = "Game %s" % [created_games.size() + 1]
		
		get_parent().add_child(making_current_game)
	
	if is_instance_valid(making_current_game):
		making_current_game.set_current_size_of_game(current_index_of_size_of_game)
	
	if making_current_game.is_finished_game():
		var made_game = making_current_game.finish_game()
		add_money(made_game.money_earned)
		
		created_games.append(made_game)
		

func add_money(value : int) -> void:
	money += value

func decrease_money(value : int) -> void:
	money -= value

func making_game(points) -> void:
	if is_instance_valid(making_current_game):
		if !making_current_game.is_finished_game():
			making_current_game.add_points(points)
			return
			
		
