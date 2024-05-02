class_name Workers extends Node2D

@export var player : Player
@export var game_time : GameTime

var workers : Array = [
	{
		name = "Designers",
		workers_role = "design",
		workers_count = 0
	},
	{
		name = "Programmers",
		workers_role = "programming",
		workers_count = 0
	},
	{
		name = "Artists",
		workers_role = "art",
		workers_count = 0
	},
]

func _ready() -> void:
	game_time.day_in_game_elapsed.connect(day_elapsed)

func add_worker(role : String, count : int) -> void:
	for i in workers:
		if i.workers_role == role:
			i.workers_count += count
			break

func day_elapsed() -> void:
	var points_to_add : Dictionary = {}
	for i in workers:
		points_to_add[i.workers_role] = i.workers_count
	
	player.making_game(points_to_add)
