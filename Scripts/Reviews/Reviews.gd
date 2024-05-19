class_name Reviews extends Node2D

@export var game_time : GameTime

var reviews : Array[Dictionary] = [
	
]

var effects : Array[Dictionary] = [
	
]
var max_effects : int = 10

var current_game : Game
var rng : RandomNumberGenerator = RandomNumberGenerator.new()


signal new_reviews
signal selected_review

func _ready() -> void:
	if game_time:
		game_time.day_in_game_elapsed.connect(_day_in_game_elapsed)

func _process(delta) -> void:
	if !is_instance_valid(current_game):
		current_game = get_tree().get_first_node_in_group("CurrentGame")
		_start_make_game()
		
	if is_instance_valid(current_game):
		if !current_game.is_connected("finished_game",_finished_game):
			current_game.finished_game.connect(_finished_game)
		
	if Input.is_action_just_pressed("test2"):
		select_review(0)
	
func select_review(index : int) -> void:
	if reviews.size() > 0:
		index = clampi(index,0,2)
		
		rng.randomize()
		var random_number : int = rng.randi_range(0,100)
		
		if random_number <= reviews[index].positive_effect.chance:
			effects.append(reviews[index].positive_effect)
		else:
			effects.append(reviews[index].negative_effect)
		
		
		reviews = []
		effects_running()
		emit_signal("selected_review")

func effects_running() -> void:
	var effects_survived : Array[Dictionary] = []
	for i in effects:
		if i.duration > 0:
			effects_survived.append(i)
	
	for i in effects_survived:
		match i.effect_type:
			"positive":
				current_game.max_development_progress = current_game.max_development_progress / i.game_production
				
				current_game.current_size_of_game.add_min_fans = current_game.current_size_of_game.add_min_fans * i.add_fans 
				current_game.current_size_of_game.add_max_fans = current_game.current_size_of_game.add_max_fans * i.add_fans 
				
				current_game.min_earnings = current_game.min_earnings * 2
				current_game.max_earnings = current_game.max_earnings * 2
				
			"negative":
				current_game.max_development_progress = current_game.max_development_progress * i.game_production
				
				current_game.current_size_of_game.add_min_fans = current_game.current_size_of_game.add_min_fans / i.add_fans 
				current_game.current_size_of_game.add_max_fans = current_game.current_size_of_game.add_max_fans / i.add_fans 
				
				current_game.min_earnings = current_game.min_earnings / 2
				current_game.max_earnings = current_game.max_earnings / 2
				
				
	effects = effects_survived
	


func _start_make_game() -> void:
	effects_running()

func _finished_game(game_info : Dictionary) -> void:
	if reviews.size() < 3 and effects.size() < max_effects:
		for i in range(3):
			
			var positive_effect_chance : int = randi_range(10,80)
			reviews.append({
				positive_effect = {
					effect_type = "positive",
					duration = rng.randi_range(1000,100000), #in seconds
					chance = positive_effect_chance,
					add_money = rng.randf_range(1,5.0),
					add_fans = rng.randf_range(1,5.0) ,
					game_production = rng.randf_range(1,5.0)
				},
				negative_effect = {
					effect_type = "negative",
					duration = rng.randi_range(1000,100000), #in seconds
					chance = 100 - positive_effect_chance,
					add_money = rng.randf_range(1,5.0),
					add_fans = rng.randf_range(1,5.0) ,
					game_production = rng.randf_range(1,5.0)
				}
			})
		
		emit_signal("new_reviews")

func _day_in_game_elapsed() -> void:
	for i in effects:
		i.duration -= 1
