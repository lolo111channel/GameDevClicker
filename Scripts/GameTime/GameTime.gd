class_name GameTime extends Node2D

var start_date_in_game : DateTime = DateTime.datetime({
	year = 1970,
	month = 1,
	day = 1
})

var current_date_in_game : DateTime

var seconds_elapsed : int = 0
var timer : Timer = Timer.new()

signal day_in_game_elapsed

func _ready() -> void:
	timer.autostart = true
	timer.wait_time = 1.0
	timer.timeout.connect(_on_timeout)
	add_child(timer)


func _process(delta) -> void:
	current_date_in_game = start_date_in_game.add_days(seconds_elapsed)


func get_current_date_in_game() -> DateTime:
	return current_date_in_game

func _on_timeout() -> void:
	seconds_elapsed += 1
	timer.start(1.0)
	
	emit_signal("day_in_game_elapsed")
