class_name UpgradeCondition extends Node2D

@export var id : String = "test"
var upgrades : Upgrades

func _ready() -> void:
	upgrades = get_parent().get_parent()

func condition(arguments : Array) -> bool:
	return false
