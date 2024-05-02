class_name GameTime extends Node2D

var start_date : DateTime = DateTime.datetime({
	year = 1970,
	month = 1,
	day = 1
})

func _ready() -> void:
	print(start_date)

func _process(delta) -> void:
	pass
