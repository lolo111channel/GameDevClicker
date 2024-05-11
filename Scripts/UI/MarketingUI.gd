extends Panel

@export var marketing_upgrade_scene : PackedScene
@export var player_ui : PlayerUI

var marketing : Marketing
var upgrades : Upgrades
var player : Player

var current_fans : int = 0
@onready var fans_count_label : Label = %FansCount
@onready var marketing_upgrades_container : GridContainer = %MarketingUpgradesContainer

func _ready() -> void:
	if player_ui:
		marketing = player_ui.get_marketing()
		upgrades = player_ui.get_uprades()
		player = player_ui.get_player()
		
	if upgrades != null:
		upgrades.new_upgrade_unlock.connect(_new_upgrade_unlock)
		pass

func _process(delta) -> void:
	
	if marketing != null:
		current_fans = lerp(current_fans,marketing.fans,0.5)
		fans_count_label.text = "%s" % [Global.rounding_value(current_fans,"")]

func _new_upgrade_unlock() -> void:
	for i in marketing_upgrades_container.get_children():
		i.queue_free()
	
	var marketing_upgrades : Array = []
	for i in upgrades.unlocked_upgrades:
		if i.upgrade_type == "marketing":
			marketing_upgrades.append(i)
	
	for i in marketing_upgrades:
		var marketing_upgrade = marketing_upgrade_scene.instantiate()
		marketing_upgrade.upgrades = upgrades
		marketing_upgrade.player = player
		marketing_upgrade.upgrade_id = i.id
		
		marketing_upgrades_container.add_child(marketing_upgrade)
		
	
