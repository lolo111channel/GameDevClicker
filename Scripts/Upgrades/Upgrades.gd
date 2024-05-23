class_name Upgrades extends Node2D

@export var workers : Workers
@export var player : Player
@export var marketing : Marketing

var upgrades_list : Array = []
var unlocked_upgrades : Array = []

@onready var conditions : Array = %Conditions.get_children()
@onready var actions : Array = %Actions.get_children()

signal upgrade_list_loaded
signal new_upgrade_unlock

func _ready() -> void:
	var upgrades_json : Array = Global.get_files_from_dir("res://Content/Upgrades/")
	for i in upgrades_json:
		var file = FileAccess.open(i,FileAccess.READ)
		var json_parse = JSON.parse_string(file.get_as_text())
		upgrades_list.append(json_parse)
	
	
	if SaveSystem.is_data_has_value(name,"upgrades_list"):
		var loaded_upgrades_data = SaveSystem.get_value_from_save(name,"upgrades_list")
		for i in loaded_upgrades_data:
			for j in upgrades_list:
				if i.id == j.id:
					j.count = i.count
			
			
	
	if upgrades_list.size() > 0:
		emit_signal("upgrade_list_loaded")
	
	if unlocked_upgrades.size() > 0:
		emit_signal("new_upgrade_unlock")
	
func _process(delta) -> void:
	for i  in upgrades_list:
		var conditions_fulfilled : bool = true
		for j in i.conditions:
			for k in conditions:
				if (k as UpgradeCondition).id == j.id:
					if (k as UpgradeCondition).condition(j.arguments):
						conditions_fulfilled = true
					else:
						conditions_fulfilled = false
						
		if conditions_fulfilled:
			if unlocked_upgrades.size() <= 0:
				unlocked_upgrades.append(i)
				emit_signal("new_upgrade_unlock")
			
			var is_find_duplicate : bool = false
			for j in unlocked_upgrades:
				if j.id == i.id:
					is_find_duplicate = true
					break
					
			if !is_find_duplicate:
				unlocked_upgrades.append(i)
				emit_signal("new_upgrade_unlock")
					
func use_upgrade(id : String) -> void:
	var searching_upgrade : Dictionary =  {}
	
	for i in upgrades_list:
		if i.id == id:
			searching_upgrade = i
			break
	
	for i in searching_upgrade.actions:
		for j in actions:
			if (j as UpgradeAction).id == i.id:
				(j as UpgradeAction).action(i.arguments)
	
	
	SaveSystem.save_data(name,"upgrades_list",upgrades_list)

func add_upgrade(id : String) -> void:
	for i in upgrades_list:
		if i.id == id:
			i.count += 1
	
	use_upgrade(id)

func get_upgrade_count(id : String) -> int:
	for i in upgrades_list:
		if i.id == id:
			return i.count
	return 0

func get_upgrade(id : String) -> Dictionary:
	for i in upgrades_list:
		if i.id == id:
			return i 
	return {} 

func get_upgrades_by_type(type:String) -> Array:
	var upgrade_with_correct_type : Array = []
	for i in upgrades_list:
		if i.upgrade_type == type:
			upgrade_with_correct_type.append(i)
	
	return upgrade_with_correct_type

func is_upgrade_unlocked(id : String) -> bool:
	for i in unlocked_upgrades:
		if i.id == id:
			return true
	
	return false

func get_price(id : String) -> int:
	var upgrade = get_upgrade(id)
	return upgrade.base_price + (upgrade.base_price * upgrade.count) * (upgrade.price_rise as float)
