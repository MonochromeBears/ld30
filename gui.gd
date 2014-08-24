
extends Control

var turelButton
var creditsLabel
var credits
var crossButton
var score
var scoreLabel
var turelsNode
var turel_scene = preload("res://turel.xml")
var reabilitation_scene = preload("res://reabilitation.xml")
# member variables here, example:
# var a=2
# var b="textvar"


func add_turel(pos):
	if (credits >= 100):
		credits = credits - 100
		creditsLabel.set_text(str(credits))
		draw_turel(pos)
		
		
func draw_turel(pos):
	var tr = turel_scene.instance()
	tr.set_pos(pos)
	turelsNode = add_child(tr)
	pass
	
func draw_center(pos):
	var dr = reabilitation_scene.instance()
	dr.set_pos(pos)
#	dr.set_pos(Vector2(lastTurelPos, 0))
	turelsNode = add_child(dr)
	
	
func add_center(pos):
	if (credits >= 20):
		credits = credits - 20
		creditsLabel.set_text(str(credits))
		draw_center(pos)

func _ready():
	#Globals.set("space_creditsLabel", 20)
	# Initalization here
	credits = 100
	score = 0
	
	#turelsNode
	turelsNode = get_node("Turels")
	
	#buttons
	turelButton = get_node("VBoxContainer").get_node("AddTurelButton")
	crossButton = get_node("VBoxContainer").get_node("AddCrossButton")

	#labels
	creditsLabel = get_node("HBoxContainer").get_node("Counts").get_node("SPACE_CREDITS_COUNT")
	scoreLabel = get_node("HBoxContainer").get_node("Counts").get_node("SCORE_COUNT")
	
	#initialize default score and credits
	creditsLabel.set_text(str(credits))
	scoreLabel.set_text(str(score))
	
	#initialize default events
	turelButton.connect("pressed", self, "_on_turel_button_pressed")
	crossButton.connect("pressed", self, "_on_turel_AddCrossButton_pressed")
	pass
	
	
func _on_turel_button_pressed():
	get_parent().show_turret_control()

func _on_AddCrossButton_pressed():
	get_parent().show_center_control()
	
func add_credits(credits_diff):
	credits += credits_diff
	creditsLabel.set_text(str(credits))
	
func add_score(score_diff):
	score += score_diff
	scoreLabel.set_text(str(score))
