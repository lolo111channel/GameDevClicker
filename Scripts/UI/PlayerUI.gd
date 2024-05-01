class_name PlayerUI extends CanvasLayer

@export var player : Player

@onready var money_label : Label = $GridContainer/GameCreator/ScrollContainer/VBoxContainer/GridContainer/MoneyLabel
@onready var created_games_label : Label = $GridContainer/GameCreator/ScrollContainer/VBoxContainer/GridContainer/CreatedGames

func _process(delta) -> void:
	
	if player:
		money_label.text = "%s$" % [player.money]
		created_games_label.text = "%s Games" % [player.created_games.size()]




func get_player() -> Player:
	if player:
		return player
		
	return null

