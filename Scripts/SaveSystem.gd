extends Node

var data_to_save : Dictionary = {
	"object_name" = [
		"parameter"
	],
	"Player" = [
		"money",
		"created_games_count",
		"player_development_points",
		"current_index_of_size_of_game"
	],
	
	"GameTime" = [
		"seconds_in_game_elapsed"
	],
	
	"Workers" = [
		"workers"
	],
	
	"Marketing" = [
		"fans",
		"marketing_power"
	],
	"Reviews" = [
		"effects"
	],
	"MainMenu" = [
		"sound_volume",
		"music_volume"
	]
}

var data : Dictionary = {
	
}

func _ready() -> void:
	load_game()

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_game()


func get_data_to_save(object_name : String) -> Array:
	var data : Array = []
	for i in data_to_save:
		if i == object_name:
			for j in data_to_save[i]:
				data.append(j)
	
	return data

func save_data(object_name : String,parameter_name : String,value) -> void:
	if data.has(object_name):
		if data[object_name].has(parameter_name):
			data[object_name][parameter_name] = value
		else:
			data[object_name][parameter_name] = value
	else:
		data[object_name] = {
			
		}
		data[object_name][parameter_name] = value


func save_game() -> void:
	var save_game = FileAccess.open("user://gamedevclicker.json",FileAccess.WRITE) 
	save_game.store_line(JSON.stringify(data))

func load_game() -> void:
	if not FileAccess.file_exists("user://gamedevclicker.json"):
		return
	
	var file : FileAccess = FileAccess.open("user://gamedevclicker.json",FileAccess.READ)
	
	var text_file_content : String = file.get_as_text()
	if text_file_content.length() > 0:
		var json_parse : Dictionary = JSON.parse_string(file.get_as_text())
		data = json_parse

func is_data_has_value(node_name : String, value_name : String) -> bool:
	if data.has(node_name):
		if data[node_name].has(value_name):
			return true
	return false

func get_value_from_save(node_name : String, value_name : String):
	if data.has(node_name):
		if data[node_name].has(value_name):
			return data[node_name][value_name]


func reset_save() -> void:
	data = {}
	save_game()
	get_tree().reload_current_scene()


