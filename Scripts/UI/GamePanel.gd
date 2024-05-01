class_name GamePanel extends Panel

var game_name : String
var how_much_earn_money : int

func _ready() -> void:
	$GridContainer/GameName.text = game_name
	$GridContainer/HowMuchEarnMoney.text = "%s$" % [how_much_earn_money]
