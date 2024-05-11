extends UpgradeAction


func action(arguments) -> void:
	var rng : RandomNumberGenerator = RandomNumberGenerator.new()
	rng.randomize()
	
	var fans = rng.randi_range(arguments[0],arguments[1])
	upgrades.marketing.add_fans(fans)
