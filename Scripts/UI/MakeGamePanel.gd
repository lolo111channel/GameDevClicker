class_name MakeGamePanel extends Panel

@export var player_ui : PlayerUI 
var player : Player

@export var game_name_label : Label 
@export var development_progress_bar : ProgressBar
@export var grid_container : GridContainer

var _progress_bars_tween_time : float = 0.1

func _ready() -> void:
	if player_ui:
		player = player_ui.get_player()

func _process(delta) -> void:
	
	pivot_offset = Vector2(size.x/2,size.y/2)
	
	if grid_container:
		grid_container.pivot_offset = Vector2(grid_container.size.x/2,grid_container.size.y/2)
	
	if player != null:
		if is_instance_valid(player.making_current_game):
			var stats : Dictionary = player.making_current_game.get_stats()
			
			
			game_name_label.text = stats.name
			
			var development_progress_tween : Tween = create_tween()
			development_progress_bar.max_value = stats.max_development_progress
			development_progress_tween.tween_property(development_progress_bar,"value",stats.development_progress,_progress_bars_tween_time)


func _on_clickable_panel_pressed():
	if player != null:
		if is_instance_valid(player.making_current_game):
			var tween : Tween = create_tween()
			tween.tween_property(self,"scale",Vector2(0.8,0.8),0.15)
			tween.tween_property(self,"scale",Vector2(1,1),0.15)
					
			player.making_game(player.player_points)
	
