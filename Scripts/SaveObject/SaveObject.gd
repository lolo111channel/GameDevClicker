class_name SaveObject extends Node

var parent_node : Node

func _ready() -> void:
	parent_node = get_parent()

	for i in SaveSystem.get_data_to_save(parent_node.name):
		if SaveSystem.data.has(parent_node.name):
			if SaveSystem.data[parent_node.name].has(i):
				parent_node.set(i,SaveSystem.data[parent_node.name][i])

func _process(delta) -> void:
	for i in SaveSystem.get_data_to_save(parent_node.name):
		SaveSystem.save_data(parent_node.name,i,parent_node.get(i))
