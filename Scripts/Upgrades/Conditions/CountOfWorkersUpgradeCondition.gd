extends UpgradeCondition


func condition(arguments : Array) -> bool:
	if upgrades.workers.get_workers_count() >= arguments[0]:
		return true
	return false
