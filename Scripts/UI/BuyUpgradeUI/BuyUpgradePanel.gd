class_name BuyUpgradePanel extends PanelContainer

@export var name_label : Label
@export var cost_label : Label
@export var upgrade_count_label : Label
@export var cover : Panel

var upgrade_id : String = ""
var upgrades : Upgrades
var player : Player

func _ready() -> void:
	var upgrade : Dictionary = upgrades.get_upgrade(upgrade_id)
	name_label.text = upgrade.upgrade_name

func _process(delta) -> void:
	pivot_offset = Global.center_pivot_offset(size)
	
	cost_label.text = "%s$" % [upgrades.get_price(upgrade_id)]
	upgrade_count_label.text = "%s" % [upgrades.get_upgrade_count(upgrade_id)] 
	
	if player != null and cover:
		cover.visible = !player.is_afford(upgrades.get_price(upgrade_id))
	
func _on_clickable_panel_pressed():
	if upgrades != null and player != null:
		if player.is_afford(upgrades.get_price(upgrade_id)):
			player.decrease_money(upgrades.get_price(upgrade_id))
			upgrades.add_upgrade(upgrade_id)
			
			Global.tween_ui_scale_animation(self,Vector2(0.8,0.8),Vector2(1.0,1.0),0.15)
	

