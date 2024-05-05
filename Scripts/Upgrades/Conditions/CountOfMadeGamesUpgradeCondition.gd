extends UpgradeCondition


func condition(arguments : Array) -> bool:
	if upgrades.player.created_games_count >= arguments[0]:
		return true
	return false
