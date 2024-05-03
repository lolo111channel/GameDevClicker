extends OptionButton

@export var player_ui : PlayerUI
var workers : Workers
var player : Player 

var sizes_of_game : Array[Dictionary] = []
var workers_needed : Array[int] = []

var new_size : bool = false

func _ready() -> void:
	if player_ui:
		workers = player_ui.get_workers()
		player = player_ui.get_player()
		
	var new_game : Game = Game.new()
	sizes_of_game = new_game.sizes_of_game
	add_child(new_game)
	new_game.queue_free()
	
	for i in sizes_of_game:
		workers_needed.append(i.workers_needed)

func _process(delta) -> void:
	pivot_offset = Global.center_pivot_offset(size)
	
	if workers != null:
		for i in workers_needed.size():
			if workers_needed[i] != -1:
				if workers.get_workers_count() >= workers_needed[i]:
					add_item(sizes_of_game[i].name)
					new_size = true
					workers_needed[i] = -1
					
					if i == 0:
						new_size = false
					
	if new_size:
		var tween : Tween = create_tween()
		tween.tween_property(self,"scale",Vector2(0.85,0.85),0.8)
		tween.tween_property(self,"scale",Vector2(1,1),0.5)


func _on_item_selected(index):
	if player != null:
		player.current_index_of_size_of_game = index
		
	new_size = false

func _on_pressed():
	new_size = false
