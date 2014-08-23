
extends Node

# member variables here, example:
# var a=2
# var b="textvar"

var world  = preload("res://Game_field.xml");

func _ready():
	# Initalization here
	pass




func _on_Button_pressed():
	add_child(world.instance())
