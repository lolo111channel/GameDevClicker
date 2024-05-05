extends UpgradeAction


func action(arguments) -> void:
	upgrades.player.add_player_development_points(arguments[0])
