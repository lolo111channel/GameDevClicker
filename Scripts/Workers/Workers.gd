class_name Workers extends Node2D

@export var player : Player
@export var game_time : GameTime

var workers : Array = [
	{
		name = "Designer",
		workers_role = "design",
		workers_count = 0,
		base_price = 500,
		current_price = 500
	},
	{
		name = "Programmer",
		workers_role = "programming",
		workers_count = 0,
		base_price = 500,
		current_price = 500
	},
	{
		name = "Artist",
		workers_role = "art",
		workers_count = 0,
		base_price = 500,
		current_price = 500
	},
]

func _ready() -> void:
	game_time.day_in_game_elapsed.connect(day_elapsed)

func add_worker(role : String, count : int) -> void:
	for i in workers:
		if i.workers_role == role:
			i.workers_count += count
			break

func buy_worker(workers_name : String) -> void:
	for i in workers:
		if i.name == workers_name:
			if player.money >= i.current_price:
				player.decrease_money(i.current_price)
				
				i.workers_count += 1
				i.current_price = i.base_price + (i.base_price * i.workers_count) * ((i.workers_count * 2) as float/100)
				
				return
			
			
func can_afford(workers_name : String) -> bool:
	if player.money >= get_workers_data(workers_name).current_price:
		return true
	return false

func get_workers_data(workers_name : String) -> Dictionary:
	for i in workers:
		if i.name == workers_name:
			return i
	
	return {}

func day_elapsed() -> void:
	var points_to_add : Dictionary = {}
	for i in workers:
		points_to_add[i.workers_role] = i.workers_count
	
	player.making_game(points_to_add)

func get_workers_count() -> int:
	var counted_workers : int = 0
	
	for i in workers:
		counted_workers += i.workers_count
	
	return counted_workers
		
