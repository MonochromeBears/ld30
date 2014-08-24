
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
var BumBoom = preload("res://BumExplode.xml")

const TIME = 5
var time = 0
func _integrate_forces(s):
	for i in range(s.get_contact_count()):
		var cc = s.get_contact_collider_object(i)
		var dp = s.get_contact_local_normal(i)
		
		if (cc):
			if (cc extends Pipe_Class):
				var new_time = OS.get_unix_time();
				if (new_time - time >= TIME && time != 0):
					var BumExploder = BumBoom.instance()
					BumExploder.set_pos(get_pos())
					BumExploder.set_emitting(true)
					get_parent().add_child(BumExploder)
					queue_free()
				elif (time == 0):
					time = new_time
				var Rcolor = cc.get_node("Sprite").get_modulate().g * 0.95
				cc.get_node("Sprite").set_modulate(Color(255,Rcolor,Rcolor))
				set_active(1)


func _ready():
	var text1 = "res://res/homless-2.png";
	var text2 = "res://res/homless.png"
	var i = randi()%2 - 1
	if (i>=0):
		var texture = ResourceLoader.load(text1)
		get_node("Sprite").set_texture(texture)
	else:
		var texture = ResourceLoader.load(text2)
		get_node("Sprite").set_texture(texture)
	return