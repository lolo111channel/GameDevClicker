class_name GameTime extends Node2D

@export var calculation_stats : CalculationStats

var start_date_in_game : DateTime = DateTime.datetime({
	year = 1970,
	month = 1,
	day = 1
})

var current_date_in_game : DateTime

var saved_date : DateTime = DateTime.datetime({
	year = 2022,
	month = 4,
	day = 1
})
var current_date : DateTime = DateTime.now()
var seconds_that_have_passed_from_last_launch : int


var seconds_in_game_elapsed : int = 0
var idle_seconds_that_elapsed : int = 0

var timer : Timer = Timer.new()

signal day_in_game_elapsed

func _ready() -> void:
	timer.autostart = true
	timer.wait_time = 1.0
	timer.timeout.connect(_on_timeout)
	add_child(timer)
	
	saved_date = current_date
	calculate_how_much_seconds_passed()
	
func _process(delta) -> void:
	current_date_in_game = start_date_in_game.add_days(seconds_in_game_elapsed)
	
	current_date = DateTime.now()
	if current_date.epoch - saved_date.epoch > 5:
		calculate_how_much_seconds_passed()
	else:
		saved_date = current_date
	
	
func calculate_how_much_seconds_passed() -> void:
	seconds_that_have_passed_from_last_launch = current_date.epoch - saved_date.epoch
	
	#1440 is minutes in one day
	seconds_in_game_elapsed = seconds_in_game_elapsed + seconds_that_have_passed_from_last_launch/1440
	idle_seconds_that_elapsed = seconds_that_have_passed_from_last_launch/1440
	
	saved_date = current_date
	
	if calculation_stats:
		calculation_stats.calculation_stats(idle_seconds_that_elapsed)
	
func get_current_date_in_game() -> DateTime:
	return current_date_in_game

func _on_timeout() -> void:
	seconds_in_game_elapsed += 1
	timer.start(1.0)
	
	emit_signal("day_in_game_elapsed")
