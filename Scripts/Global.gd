extends Node

func center_pivot_offset(size:Vector2) -> Vector2:
	return Vector2(size.x/2,size.y/2)

func tween_ui_scale_animation(object:Control,min : Vector2, max : Vector2 ,duration : float) -> void:
	var tween : Tween = create_tween()
	tween.tween_property(object,"scale",min,duration)
	tween.tween_property(object,"scale",max,duration)


func rounding_value(moneyx:float,y:String) -> String:
	var x:float
	
	if(moneyx >= 1000 and moneyx < 1000000):
		x = moneyx / 1000;
		y = str(snapped(x,0.001)) + "K"
	elif(moneyx >= 1000000 and  moneyx < 1000000000):
		x = moneyx / 1000000
		y =  str(snapped(x,0.001)) + "M"   
	elif(moneyx >= 1000000000 and moneyx < 1000000000000 ):
		x = moneyx / 1000000000;
		y = str(snapped(x,0.001)) + "B"
	elif(moneyx >= 1000000000000):
		x = moneyx / 1000000000000;
		y = str(snapped(x,0.001)) + "T"
	else:
		y = str(snapped(moneyx,0.001))
		
	return y;
