class_name PlayerUI extends CanvasLayer

@export var player : Player


func get_player() -> Player:
	if player:
		return player
		
	return null

