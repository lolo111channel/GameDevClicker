extends OptionButton

@export var player_ui : PlayerUI
var workers : Workers

var sizes_of_game : Array[Dictionary] = []
var workers_needed : Array[int] = []

func _ready() -> void:
	
	if player_ui:
		workers = player_ui.get_workers()
		
	var new_game : Game = Game.new()
	sizes_of_game = new_game.sizes_of_game
	add_child(new_game)
	new_game.queue_free()
	
	for i in sizes_of_game:
		workers_needed.append(i.workers_needed)

func _process(delta) -> void:
	
	if workers != null:
		for i in workers_needed.size():
			if workers_needed[i] != -1:
				if workers.get_workers_count() >= workers_needed[i]:
					add_item(sizes_of_game[i].name)
					
					workers_needed[i] = -1
	
