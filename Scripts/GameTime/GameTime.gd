class_name GameTime extends Node2D

@export var calculation_stats : CalculationStats

var start_date_in_game : DateTime = DateTime.datetime({
	year = 1970,
	month = 1,
	day = 1
})

var current_date_in_game : DateTime

var saved_date : DateTime
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
	
	if SaveSystem.is_data_has_value(name,"date"):
		saved_date = DateTime.datetime(SaveSystem.get_value_from_save(name,"date"))
	else:
		saved_date = DateTime.now()
	
	calculate_how_much_seconds_passed()
	
	
func _process(delta) -> void:
	current_date_in_game = start_date_in_game.add_days(seconds_in_game_elapsed)
	
	current_date = DateTime.now()
	if current_date.epoch - saved_date.epoch > 5:
		calculate_how_much_seconds_passed()
	else:
		saved_date = current_date

	
	if Input.is_action_just_pressed("test"):
		saved_date = DateTime.datetime({
			year = 2023
		})
	
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
	
	SaveSystem.save_data(name,"date",{
		"year":current_date.year,
		"month":current_date.month,
		"day":current_date.day,
		"hour":current_date.hour,
		"minute":current_date.minute,
		"second":current_date.second
	})
	
	SaveSystem.save_game()
	emit_signal("day_in_game_elapsed")
