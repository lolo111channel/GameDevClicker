class_name MakeGamePanel extends Panel

@export var player_ui : PlayerUI 
var player : Player
var disappearing_text_container : DisappearingTextContainer

@onready var game_name_label : Label = %GameName
@onready var development_progress_bar : ProgressBar = %DevelopmentProgress
@onready var grid_container : GridContainer = %GridContainer

@onready var development_progress_label : Label = $MarginContainer/GridContainer/DevelopmentProgress/Label

var _progress_bars_tween_time : float = 0.1

func _ready() -> void:
	if player_ui:
		player = player_ui.get_player()
		disappearing_text_container = player_ui.get_disappearing_text_container()

func _process(delta) -> void:
	
	pivot_offset = Vector2(size.x/2,size.y/2)
	
	development_progress_label.text = "%s/%s" % [development_progress_bar.value,development_progress_bar.max_value]
	
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
			
			if disappearing_text_container != null:
				var rng : RandomNumberGenerator = RandomNumberGenerator.new()
				rng.randomize()
				var x : float = rng.randf_range(-25.0,25.0)
				var y : float = rng.randf_range(-25.0,25.0)
				
				var text_pos : Vector2 = Vector2(get_global_mouse_position().x + x, get_global_mouse_position().y + y)
				disappearing_text_container.spawn_text("+%s" % [player.player_development_points],text_pos)
			
			player.making_game(player.player_development_points)
	
