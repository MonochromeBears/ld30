
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var LockOnTarget # Turred aimed at this
var Targets = []
var Turret

func _ready():
	Turret = get_child("Telo").get_child("turel")
	set_fixed_process(true)
	pass
	
func _fixed_process(delta):
	if(!LockOnTarget):
		if(Targets.size()):
			LockOnTarget = Targets[0]
	else:
		var VectorGun = Turret.get_pos()
		var VectorBum = LockOnTarget.get_pos()
		var Angle = VectorGun.angle_to(VectorBum)
		Turret.set_rot(Angle)
		
		Targets.erase(LockOnTarget)
		LockOnTarget.get_parent().remove_and_delete_child(LockOnTarget)
		LockOnTarget = null
		
	
func _on_Area2D_body_enter( body ):
	Targets.push_back(body)

func _on_Area2D_body_exit( body ):
	if(Targets.find(body)):
		Targets.erase(body)
