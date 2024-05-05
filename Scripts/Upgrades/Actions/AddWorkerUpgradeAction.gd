extends UpgradeAction


func action(arguments) -> void:
	upgrades.workers.add_worker(arguments[0],arguments[1])
