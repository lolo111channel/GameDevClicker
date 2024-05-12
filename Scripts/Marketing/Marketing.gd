class_name Marketing extends Node2D

@export var game_time : GameTime
var fans : int = 0
var whole_fan : float = 0.0

var current_game : Game
var marketing_power : float = 0.0

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	if game_time:
		game_time.day_in_game_elapsed.connect(_day_in_game_elapsed)

func _process(delta) -> void:
	if !is_instance_valid(current_game):
		current_game = get_tree().get_first_node_in_group("CurrentGame")
		
		
	if is_instance_valid(current_game):
		if !current_game.is_connected("finished_game",_finished_game):
			current_game.marketing = self
			current_game.finished_game.connect(_finished_game)

func add_fans(value : int) -> void:
	fans += value

func get_fans() -> int:
	return fans

func add_marketing_power(value : float) -> void:
	marketing_power += value

func get_money_that_fans_give() -> int:
	rng.randomize()
	var add_money : int = rng.randi_range(fans/4,fans/2)
	return add_money

func _finished_game(game_info : Dictionary) -> void:
	rng.randomize()
	var add_fans : int = rng.randi_range(game_info.size_of_game.add_min_fans,game_info.size_of_game.add_max_fans)
	fans += add_fans + add_fans * marketing_power

func _day_in_game_elapsed() -> void:
	whole_fan += marketing_power
	if whole_fan >= 1:
		fans += roundi(whole_fan)
		whole_fan = 0.0

