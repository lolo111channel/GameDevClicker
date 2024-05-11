class_name Marketing extends Node2D

@export var player : Player
var fans : int = 0

var current_game : Game

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func _process(delta) -> void:
	if !is_instance_valid(current_game):
		current_game = get_tree().get_first_node_in_group("CurrentGame")
		
		
	if is_instance_valid(current_game):
		if !current_game.is_connected("finished_game",_finished_game):
			current_game.marketing = self
			current_game.finished_game.connect(_finished_game)

func add_fans(value : int) -> void:
	fans += value

func get_money_that_fans_give() -> int:
	rng.randomize()
	var add_money : int = rng.randi_range(fans/4,fans/2)
	return add_money

func _finished_game(game_info : Dictionary) -> void:
	rng.randomize()
	fans += rng.randi_range(game_info.size_of_game.add_min_fans,game_info.size_of_game.add_max_fans)
