class_name UpgradeAction extends Node2D

@export var id : String = "test"
var upgrades : Upgrades

func _ready() -> void:
	upgrades = get_parent().get_parent()


func action(arguments : Array) -> void:
	print(arguments)
	pass
