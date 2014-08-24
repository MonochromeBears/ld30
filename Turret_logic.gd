
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
var Collider
var cooldown = 20 #frames cooldown
var cantshoot = 0
var turret_range = 500

var shots_fired = 0

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
	Collider = get_child("Telo").get_child("Area2D")
	set_fixed_process(true)
	pass
	
func _shoot_lazor(LockOnTarget):
	shots_fired += 1
	cantshoot = cooldown
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
	
func len_to_target(From, Target):
	var dx = From.x - Target.x
	var dy = From.y - Target.y
	return Vector2(dx,dy).length() #.length()/2
	
	
func _fixed_process(delta):
	if (shots_fired >= 150):
		queue_free()
	if(cantshoot):
		cantshoot -= 1
	else:
		var parent = get_parent().get_parent()
		#var name = parent.get_name()
		for Obj in parent.get_children():
			if(Obj extends homeless):
				if(len_to_target(get_pos(), Obj.get_pos()) > turret_range):
					continue
				_shoot_lazor(Obj)
				Obj.get_parent().remove_and_delete_child(Obj)
				var par = get_parent()
				par.add_credits(1)
				par.add_score(5)
				return
			if(Obj extends boss):
				if(len_to_target(get_pos(), Obj.get_pos()) > turret_range):
					continue
				_shoot_lazor(Obj)
				if(Obj.damage()):
					Obj.get_parent().remove_and_delete_child(Obj)
					var par = get_parent()
					par.add_credits(20)
					par.add_score(100)
				return