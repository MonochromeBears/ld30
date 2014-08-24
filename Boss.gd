
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var health = 10

func damage():
	if(health > 0):
		health-=1
		return 0
	else:
		return 1
