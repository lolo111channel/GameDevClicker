class_name MakeGamePanel extends Panel

@export var player_ui : PlayerUI 
var player : Player

@export var game_name_label : Label 
@export var design_progress_bar : ProgressBar
@export var programming_progress_bar : ProgressBar 
@export var art_progress_bar : ProgressBar
@export var grid_container : GridContainer

var _progress_bars_tween_time : float = 0.1

func _ready() -> void:
	if player_ui:
		player = player_ui.get_player()

func _process(delta) -> void:
	if player != null:
		if is_instance_valid(player.making_current_game):
			var stats : Dictionary = player.making_current_game.get_stats()
			
			
			game_name_label.text = stats.name
			
			var design_tween : Tween = create_tween()
			design_progress_bar.max_value = stats.max_design
			design_tween.tween_property(design_progress_bar,"value",stats.design,_progress_bars_tween_time)
			
			var programming_tween : Tween = create_tween()
			programming_progress_bar.max_value = stats.max_programming
			programming_tween.tween_property(programming_progress_bar,"value",stats.programming,_progress_bars_tween_time)
			
			
			var art_tween : Tween = create_tween()
			art_progress_bar.max_value = stats.max_art
			art_tween.tween_property(art_progress_bar,"value",stats.art,_progress_bars_tween_time)


func _on_clickable_panel_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			if player != null:
				if is_instance_valid(player.making_current_game):
					player.making_game()
	
