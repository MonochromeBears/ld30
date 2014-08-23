
extends Control

var turelButton
var creditsLabel
var credits
var crossButton
var score
var scoreLabel
# member variables here, example:
# var a=2
# var b="textvar"


func add_turel():
	if (credits >= -20):
		credits = credits - 20
		creditsLabel.set_text(str(credits))
		draw_turel()
		
		
func draw_turel():
	pass
	
func draw_center():
	pass
	
func add_center():
	if (credits >= 100):
		credits = credits - 100
		creditsLabel.set_text(str(credits))
		draw_center()

func _ready():
	#Globals.set("space_creditsLabel", 20)
	# Initalization here
	credits = 2000
	score = 0
	
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
	add_turel()







func _on_AddCrossButton_pressed():
	add_center()
	pass # replace with function body
