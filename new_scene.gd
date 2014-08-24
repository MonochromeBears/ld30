
extends Node

# member variables here, example:
# var a=2
# var b="textvar"

var FallinBum = preload("res://FallingBum.xml")
var DropWidth = 9*32 
var SceneCenter = 17*32
var RndArray = [-1,1]
func _ready():
	set_fixed_process(true)
	pass

func generate_obstacle():
	var obst = FallinBum.instance()
	var posX = SceneCenter + DropWidth * randf() * RndArray[randi() % 2]
	var poxY = 0
	obst.set_pos(Vector2(posX,poxY))
	add_child(obst)

func _fixed_process(delta):
	if (randi()%100 < 20):
		generate_obstacle()
