
extends StaticBody2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	get_node("Sprite").set_modulate(Color(255,255,255))
	pass

func is_broken():
	var mod = get_node("Sprite").get_modulate()
	return mod.g <= 5 && mod.b <= 5
