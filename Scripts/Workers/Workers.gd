class_name Workers extends Node2D

@export var player : Player
@export var game_time : GameTime

var workers : Array = [
	{
		name = "Game Developer",
		workers_role = "game_developer",
		workers_count = 0,
	},
]

func _ready() -> void:
	game_time.day_in_game_elapsed.connect(day_elapsed)

func add_worker(role : String, count : int) -> void:
	for i in workers:
		if i.workers_role == role:
			i.workers_count += count
			break


func get_workers_data(workers_name : String) -> Dictionary:
	for i in workers:
		if i.name == workers_name:
			return i
	
	return {}

func day_elapsed() -> void:
	var development_points : int = 0
	for i in workers:
		development_points += i.workers_count
		
	player.making_game(development_points)

func get_workers_count() -> int:
	var counted_workers : int = 0
	
	for i in workers:
		counted_workers += i.workers_count
	
	return counted_workers
		
func get_workers_points() -> int:
	var points : int = 0
	for i in workers:
		points += i.workers_count
	
	return points
