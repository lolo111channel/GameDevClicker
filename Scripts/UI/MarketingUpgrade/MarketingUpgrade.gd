class_name MarketingUpgrade extends PanelContainer

var upgrade_id : String = ""
var upgrades : Upgrades
var player : Player

func _on_clickable_panel_pressed():
	if upgrades != null and player != null:
		if player.is_afford(upgrades.get_price(upgrade_id)):
			player.decrease_money(upgrades.get_price(upgrade_id))
			upgrades.add_upgrade(upgrade_id)
			
			Global.tween_ui_scale_animation(self,Vector2(0.8,0.8),Vector2(1.0,1.0),0.15)
