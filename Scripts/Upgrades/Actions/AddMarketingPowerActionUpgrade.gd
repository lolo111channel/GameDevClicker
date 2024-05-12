extends UpgradeAction


func action(arguments) -> void:
	upgrades.marketing.add_marketing_power(arguments[0])
