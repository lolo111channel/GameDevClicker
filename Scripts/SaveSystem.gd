extends Node

var data_to_save : Dictionary = {
	"object_name" = [
		"parameter"
	],
	"Player" = [
		"money"
	]
}

var data : Dictionary = {
	
}

func _ready() -> void:
	load_game()


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
	var json_parse : Dictionary = JSON.parse_string(file.get_as_text())
	data = json_parse

