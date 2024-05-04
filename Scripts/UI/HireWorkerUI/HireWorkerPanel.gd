extends PanelContainer

@export var role_name : String = "Game Developer"
@export var player_ui : PlayerUI
@export var name_label : Label
@export var cost_label : Label
@export var workers_count_label : Label
@export var cover : Panel

var workers : Workers
var can_buy : bool = true

func _ready() -> void:
	if player_ui:
		workers = player_ui.get_workers() 
		
	if workers != null:
		name_label.text = workers.get_workers_data(role_name).name

func _process(delta) -> void:
	can_buy = workers.can_afford(role_name)
	cover.visible = !can_buy
	pivot_offset = Global.center_pivot_offset(size)
	
	if workers != null:
		workers_count_label.text = str(workers.get_workers_data(role_name).workers_count)
		cost_label.text = "%s$" % [workers.get_workers_data(role_name).current_price]

func _on_clickable_panel_pressed():
	if workers != null:
		if can_buy:
			workers.buy_worker(role_name)
			
			Global.tween_ui_scale_animation(self,Vector2(0.8,0.8),Vector2(1,1),0.15)

	
	

