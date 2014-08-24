extends Node

# member variables here, example:
# var a=2
# var b="textvar"

var FallinBum = preload("res://FallingBum.xml")
var DropWidth = 20*32 
var SceneCenter = 20*32
var RndArray = [-1,1]

var game_over = false

func _ready():
	set_fixed_process(true)
	set_process_input(true)
	get_node("TurrelControl").hide()
	get_node("CenterControl").hide()
	get_node("game_over").hide()
	pass

func generate_obstacle():
	if (game_over):
		return
	var obst = FallinBum.instance()
	var posX = SceneCenter + DropWidth * randf() * RndArray[randi() % 2]
	var poxY = 0
	obst.set_pos(Vector2(posX,poxY))
	add_child(obst)

func _fixed_process(delta):
	if (randi()%100 < 4):
		generate_obstacle()
	check_pipe()



func _on_Restart_pressed():
	get_node("/root/global").goto_scene("res://splash.xml")
	
var startInputProcessing
var inputType # 1 - turret, 2 - center



func _input( ev ):
	if (!startInputProcessing || game_over):
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
	
func check_pipe():
	var trassa = get_node("trassa")
	var count_broken = 0
	for i in range(0, trassa.get_child_count()):
		var pipe_part = trassa.get_child(i)
		if (pipe_part.is_broken()):
			count_broken += 1
	if (count_broken >= 16):
		get_node("game_over").show()
		game_over = true
	pass
