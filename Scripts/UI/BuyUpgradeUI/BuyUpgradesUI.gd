extends Panel

@export var player_ui : PlayerUI 
@export var buy_upgrade_panel_scene : PackedScene
@export var buy_upgrade_panel_locked_scene : PackedScene

@onready var upgrade_list : GridContainer = %UpgradeList

var upgrades : Upgrades
var player : Player

var buy_upgrade_panel_children : Array = []
var added_upgrades : Array = []

func _ready() -> void:
	if player_ui:
		upgrades = player_ui.get_uprades()
		player = player_ui.get_player()
			
	if upgrades != null:
		upgrades.new_upgrade_unlock.connect(load_upgrades_panel_to_scene)


func add_upgrades(upgrades : Array) -> void:
	for i in upgrades:
		if !added_upgrades.has(i):
			added_upgrades.append(i)

func clear_added_upgrades() -> void:
	for i in buy_upgrade_panel_children:
		if is_instance_valid(i):
			i.queue_free()
	
	added_upgrades = []


func load_upgrades_panel_to_scene() -> void:
	clear_added_upgrades()
	add_upgrades(upgrades.get_upgrades_by_type("ordinary"))
	
	for i in added_upgrades:
		if upgrades.is_upgrade_unlocked(i.id):
			var buy_upgrade_panel : BuyUpgradePanel = buy_upgrade_panel_scene.instantiate()
			buy_upgrade_panel.upgrade_id = i.id
			buy_upgrade_panel.upgrades = upgrades
			buy_upgrade_panel.player = player
			
			buy_upgrade_panel_children.append(buy_upgrade_panel)
			upgrade_list.add_child(buy_upgrade_panel)
		else:
			var buy_upgrade_panel : BuyUpgradePanel = buy_upgrade_panel_locked_scene.instantiate()
			buy_upgrade_panel.upgrade_id = i.id
			buy_upgrade_panel.upgrades = upgrades
			buy_upgrade_panel.player = player
			
			buy_upgrade_panel_children.append(buy_upgrade_panel)
			upgrade_list.add_child(buy_upgrade_panel)
			
			
	
	#var ordinary_upgrades : Array = []
	#for i in upgrades.unlocked_upgrades:
	#	if i.upgrade_type == "ordinary":
	#		ordinary_upgrades.append(i)
	
	#if ordinary_upgrades.size() > 0:
	#	for i in ordinary_upgrades:
	#		
	#		var is_find_duplicate : bool = false
	#		for j in buy_upgrade_panel_list:
	#			if i.id == (j as BuyUpgradePanel).upgrades.get_upgrade(j.upgrade_id).id:
	#				is_find_duplicate = true
	#				break
	#		
	#		if !is_find_duplicate:
	#			var buy_upgrade_panel : BuyUpgradePanel = buy_upgrade_panel_scene.instantiate()
	#			buy_upgrade_panel.upgrade_id = i.id
	#			buy_upgrade_panel.upgrades = upgrades
	#			buy_upgrade_panel.player = player
	#				
	#			upgrade_list.add_child(buy_upgrade_panel)
	#			buy_upgrade_panel_list.append(buy_upgrade_panel)
