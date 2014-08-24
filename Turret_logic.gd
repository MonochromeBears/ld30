
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var homeless = preload("res://FallingBum.gd")
var Laser = preload("res://laser.xml")
var BumBoom = preload("res://BumExplode.xml")
var boss = preload("res://Boss.gd")
#var gui = preload("res://gui.gd")

var LockOnTarget # Turred aimed at this
var Targets = []
var Turret
var cooldown = 10 #frames cooldown
var cantshoot = 0

func offset_vector(VectorOne, VectorTwo):
	var dots = []
	var dx = VectorTwo.x - VectorOne.x
	var dy = VectorTwo.y - VectorOne.y
	return Vector2(Vector2(dx,dy).length(),0) #.length()/2
	#dx = dx/len
	#dy = dy/len
	#while(len > 0):
	#	len -= 1
	#	dots.push_back(Vector2(VectorOne.x + dx*len, VectorOne.y + dy*len))
	#return Vector2Array(dots)
	
func _ready():
	Turret = get_child("Telo").get_child("turel")
	set_fixed_process(true)
	pass
	
func _shoot_lazor():
	var VectorGun = get_pos()
	var VectorBum = LockOnTarget.get_pos()
	var Angle = VectorGun.angle_to_point(VectorBum)
	Turret.set_rot(Angle)
	var lazor = Laser.instance()
	lazor.set_emission_half_extents(offset_vector(VectorGun,VectorBum))
	lazor.set_emitting(true)
	lazor.set_rot(Angle - (3.14 / 2))
	add_child(lazor)
	var VectorGun = get_pos()
	var VectorBum = LockOnTarget.get_pos()
	var Angle = VectorGun.angle_to_point(VectorBum)
	Turret.set_rot(Angle)
	var BumExploder = BumBoom.instance()
	BumExploder.set_pos(VectorBum)
	BumExploder.set_emitting(true)
	get_parent().add_child(BumExploder)
	
	
func _fixed_process(delta):
	if(cantshoot):
		cantshoot -= 1
	else:
		if(!LockOnTarget):
			if(Targets.size()):
				LockOnTarget = Targets[0]
		else:
			cantshoot = cooldown
			if(LockOnTarget extends homeless):
				_shoot_lazor()
				Targets.erase(LockOnTarget)
				LockOnTarget.get_parent().remove_and_delete_child(LockOnTarget)
				LockOnTarget = null
				var par = get_parent()
				par.add_credits(5)
				par.add_score(5)
				return
			if(LockOnTarget extends boss):
				_shoot_lazor()
				if(LockOnTarget.damage()):
					Targets.erase(LockOnTarget)
					LockOnTarget.get_parent().remove_and_delete_child(LockOnTarget)
					LockOnTarget = null
					var par = get_parent()
					par.add_credits(5)
					par.add_score(5)
				return
			
			#var par = self.get_parent()
		
	
func _on_Area2D_body_enter( body ):
	if ((body extends homeless) || (body extends boss)):
		Targets.push_back(body)

func _on_Area2D_body_exit( body ):
	if ((body extends homeless) || (body extends boss)):
		if(Targets.find(body)):
			Targets.erase(body)
