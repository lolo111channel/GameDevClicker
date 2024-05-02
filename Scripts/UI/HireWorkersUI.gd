extends Panel

@export var player_ui : PlayerUI
@export var grid_container : GridContainer
var workers : Workers

var workers_count_labels : Array

func _ready() -> void:
	if player_ui:
		workers = player_ui.get_workers() 
	
	if workers != null:
		for i in workers.workers:
			var new_label : Label = Label.new()
			workers_count_labels.append(new_label)
			
			if grid_container:
				grid_container.add_child(new_label)

func _process(delta) -> void:
	
	if workers != null:
		for i in workers.workers.size():
			workers_count_labels[i].text = "%s %s" % [workers.workers[i].workers_count, workers.workers[i].name]

