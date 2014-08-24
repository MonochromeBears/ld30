extends Node

# member variables here, example:
# var a=2
# var b="textvar"

var FallinBum = preload("res://FallingBum.xml")
var DropWidth = 6*32 
var SceneCenter = 17*32
var RndArray = [-1,1]
func _ready():
	set_fixed_process(true)
	set_process_input(true)
	get_node("TurrelControl").hide()
	get_node("CenterControl").hide()
	pass

func generate_obstacle():
	var obst = FallinBum.instance()
	var posX = SceneCenter + DropWidth * randf() * RndArray[randi() % 2]
	var poxY = 0
	obst.set_pos(Vector2(posX,poxY))
	add_child(obst)

func _fixed_process(delta):
	if (randi()%100 < 4):
		generate_obstacle()



func _on_Restart_pressed():
	get_node("/root/global").goto_scene("res://splash.xml")
	
var startInputProcessing
var inputType # 1 - turret, 2 - center



func _input( ev ):
	if (!startInputProcessing):
		return
	var object
	if inputType == 1:
		object = get_node("TurrelControl")
	else:
		object = get_node("CenterControl")
	object.show()
	Input.set_mouse_mode(1)
	if (ev.type==InputEvent.MOUSE_BUTTON):
#		print("Mouse Click/Unclick at: ",ev.pos)
		startInputProcessing = false
		object.hide()
		Input.set_mouse_mode(0)
		#var pos_x = ev.pos.x
		if inputType == 1:
			get_node("GUI").add_turel(Vector2(round(ev.pos.x / 64) * 64, 600))
		elif inputType == 2:
			get_node("GUI").add_center(Vector2(round(ev.pos.x / 64) * 64, 600))
	elif (ev.type==InputEvent.MOUSE_MOTION):
#		print("Mouse Motion at: ",ev.pos)
		object.set_pos(ev.pos)

func show_turret_control():
	startInputProcessing = true
	inputType = 1
	
func show_center_control():
	startInputProcessing = true
	inputType = 2
