extends Panel

@onready var music_label : Label = $ScrollContainer/VBoxContainer/MarginContainer/MainMenuUIElements/MarginContainer2/GridContainer/MusicLabel
@onready var music_count : Label = $ScrollContainer/VBoxContainer/MarginContainer/MainMenuUIElements/MarginContainer2/GridContainer/MusicCount
@onready var music_slider : HSlider = $ScrollContainer/VBoxContainer/MarginContainer/MainMenuUIElements/MarginContainer2/GridContainer/MusicSlider

@onready var sound_label : Label = $ScrollContainer/VBoxContainer/MarginContainer/MainMenuUIElements/MarginContainer2/GridContainer/SoundLabel
@onready var sound_count : Label = $ScrollContainer/VBoxContainer/MarginContainer/MainMenuUIElements/MarginContainer2/GridContainer/SoundCount
@onready var sound_slider : HSlider = $ScrollContainer/VBoxContainer/MarginContainer/MainMenuUIElements/MarginContainer2/GridContainer/SoundSlider

@onready var new_game_button : Button = $ScrollContainer/VBoxContainer/MarginContainer/MainMenuUIElements/MarginContainer2/GridContainer/NewGame
@onready var are_you_sure : Control = $ScrollContainer/VBoxContainer/MarginContainer/MainMenuUIElements/MarginContainer2/GridContainer/AreYouSure

var music_volume : float = 0
var sound_volume : float = 0

func _ready() -> void:
	
	if SaveSystem.is_data_has_value(name,"music_volume"):
		music_volume = SaveSystem.get_value_from_save(name,"music_volume")
	
	if SaveSystem.is_data_has_value(name,"volume_volume"):
		sound_volume = SaveSystem.get_value_from_save(name,"sound_volume")
	
	music_slider.value = music_volume
	sound_slider.value = sound_volume
	apply_settings()

func _process(delta) -> void:
	music_count.text = str(music_slider.value * 100) + "%"
	sound_count.text = str(sound_slider.value * 100) + "%"
	

func apply_settings() -> void:
	if music_slider and sound_slider:
	
		var bus_index = AudioServer.get_bus_index("Music")
		AudioServer.set_bus_volume_db(
			bus_index,
			linear_to_db(music_slider.value)
		)
		
		bus_index = AudioServer.get_bus_index("Sounds")
		AudioServer.set_bus_volume_db(
			bus_index,
			linear_to_db(sound_slider.value)
		)
	
		music_volume = music_slider.value
		sound_volume = sound_slider.value
	
func _on_apply_settings_pressed():
	apply_settings()


func _on_new_game_pressed():
	new_game_button.visible = false
	are_you_sure.visible = true



func _on_yes_pressed():
	SaveSystem.reset_save()


func _on_no_pressed():
	new_game_button.visible = true
	are_you_sure.visible = false



