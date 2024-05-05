class_name PlayerUI extends CanvasLayer

@export var player : Player
@export var game_time : GameTime
@export var workers : Workers
@export var upgrades : Upgrades

func get_player() -> Player:
	if player:
		return player
		
	return null

func get_game_time() -> GameTime:
	if game_time:
		return game_time
	return null

func get_workers() -> Workers:
	if workers:
		return workers
	return null

func get_uprades() -> Upgrades:
	if upgrades:
		return upgrades
	return null
