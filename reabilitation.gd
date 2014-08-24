
extends Node2D
var reab
var counter = 0
var health = 5
var homeless = preload("res://FallingBum.gd")
# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	pass





func _on_Area2D_body_exit( body ):
	pass
	#body.get_parent().remove_and_delete_child(body)

	#body.get_parent().remove_and_delete_child(body)



func _on_Area2D_body_enter( body ):
	var name = get_name()
	var parent = get_parent()
	if body extends homeless:
		body.get_parent().remove_and_delete_child(body)
		parent.add_credits(10)
		parent.add_score(20)
		if health == 0:
			queue_free()
		health -= 1
	pass # replace with function body
