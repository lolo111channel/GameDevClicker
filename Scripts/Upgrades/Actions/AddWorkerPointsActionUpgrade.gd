extends UpgradeAction


func action(arguments) -> void:
	upgrades.workers.add_power_points_of_manager(arguments[0])
