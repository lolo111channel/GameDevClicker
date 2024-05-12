extends UpgradeCondition


func condition(arguments : Array) -> bool:
	if upgrades.marketing.get_fans() >= arguments[0]:
		return true
	return false
