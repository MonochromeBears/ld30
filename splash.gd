
extends Node

# member variables here, example:
# var a=2
# var b="textvar"

var world = preload("res://Game_field.xml");
var worldInstance

func _ready():
	worldInstance = world.instance()


func _on_Button_pressed():
	get_node("/root/global").goto_scene("res://Game_field.xml")