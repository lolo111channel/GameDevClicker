class_name SaveObject extends Node

var parent_node : Node

func _ready() -> void:
	parent_node = get_parent()

	for i in SaveSystem.data_to_save:
		if i == parent_node.name:
			for j in SaveSystem.data_to_save[i]:
				if j in parent_node:
					parent_node.set(j,SaveSystem.data[i][j])

func _process(delta) -> void:
	for i in SaveSystem.data_to_save:
		if i == parent_node.name:
			for j in SaveSystem.data_to_save[i]:
				if j in parent_node:
					SaveSystem.save_data(i,j,parent_node.get(j))
