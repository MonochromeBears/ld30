
extends RigidBody2D

# member variables here, example:
# var a=2
# var b="textvar"

const STATE_WALKING = 0
const STATE_DYING = 1


var state = STATE_WALKING


var direction = -1
var anim=""


var Pipe_Class = preload("res://Pipe.gd")


func _integrate_forces(s):
	for i in range(s.get_contact_count()):
		var cc = s.get_contact_collider_object(i)
		var dp = s.get_contact_local_normal(i)
		
		if (cc):
			if (cc extends Pipe_Class):
				var Rcolor = cc.get_node("Sprite").get_modulate().g * 0.95
				cc.get_node("Sprite").set_modulate(Color(255,Rcolor,Rcolor))
				set_active(1)


func _ready():
	return