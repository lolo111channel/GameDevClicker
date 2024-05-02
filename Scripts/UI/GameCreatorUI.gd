extends Panel

@export var player_ui : PlayerUI
@export var grid_container : GridContainer
@export var game_panel_scene : PackedScene

@export var money_label : Label
@export var created_games_label : Label
@export var date_in_game_label : Label

var player : Player
var game_time : GameTime

var created_games_amount : int = 0
var current_money : int = 0

func _ready() -> void:
	if player_ui:
		player = player_ui.get_player()
		game_time = player_ui.get_game_time()

func _process(delta) -> void:
	
	if game_time != null:
		var current_date_in_game : DateTime = game_time.get_current_date_in_game()
		if current_date_in_game != null:
			date_in_game_label.text = current_date_in_game.strftime("%d %B %Y")
		
		pass
	
	if player != null:
		
		
		
		current_money = lerp(current_money,player.money+1,0.5)
		money_label.text = "%s$" % [current_money]
			
		created_games_label.text = "%s Games" % [player.created_games.size()]
		
		
		if created_games_amount != player.created_games.size():
			created_games_amount = player.created_games.size()
			
			for i in grid_container.get_children():
				i.queue_free()
				
			if created_games_amount != 5:
				
				for i in created_games_amount:
					var game_panel : GamePanel = game_panel_scene.instantiate()
					
					
					game_panel.game_name = player.created_games[-i-1].name
					game_panel.how_much_earn_money = player.created_games[-i-1].money_earned
				
					grid_container.add_child(game_panel)
		
			else:
				
				for i in 5:
					var game_panel : GamePanel = game_panel_scene.instantiate()
					
					
					game_panel.game_name = player.created_games[-i-1].name
					game_panel.how_much_earn_money = player.created_games[-i-1].money_earned
				
					grid_container.add_child(game_panel)
			
		


