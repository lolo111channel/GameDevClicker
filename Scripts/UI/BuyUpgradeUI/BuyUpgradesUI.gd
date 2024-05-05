extends Panel

@export var player_ui : PlayerUI 
@export var buy_upgrade_panel_scene : PackedScene
@onready var upgrade_list : GridContainer = %UpgradeList

var upgrades : Upgrades
var player : Player

var buy_upgrade_panel_list : Array = []

func _ready() -> void:
	if player_ui:
		upgrades = player_ui.get_uprades()
		player = player_ui.get_player()
			
	if upgrades != null:
		upgrades.new_upgrade_unlock.connect(load_upgrades_panel)

			
func load_upgrades_panel() -> void:
	for i in upgrades.unlocked_upgrades:
		
		var is_find_duplicate : bool = false
		for j in buy_upgrade_panel_list:
			if i.id == (j as BuyUpgradePanel).upgrades.get_upgrade(j.upgrade_id).id:
				is_find_duplicate = true
				break
		
		if !is_find_duplicate:
			var buy_upgrade_panel : BuyUpgradePanel = buy_upgrade_panel_scene.instantiate()
			buy_upgrade_panel.upgrade_id = i.id
			buy_upgrade_panel.upgrades = upgrades
			buy_upgrade_panel.player = player
				
			upgrade_list.add_child(buy_upgrade_panel)
			buy_upgrade_panel_list.append(buy_upgrade_panel)
