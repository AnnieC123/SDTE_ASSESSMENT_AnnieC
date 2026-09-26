# TUTORIALS
extends Control

var current_tutorial = 0

# list of tutorials
@onready var tutorials = [
	$tutorial_1,
	$tutorial_2,
	$tutorial_3,
	$tutorial_4,
	$tutorial_5,
	$tutorial_6,
]
# buttons
@onready var back_button = $back_button
@onready var next_button = $next_button

func _ready() -> void:
	show_tutorial()
	
# hides all tutorial then shows the current tutorial
func show_tutorial():
	for tutorial in tutorials:
		tutorial.hide()
		
	tutorials[current_tutorial].show()
	back_button.disabled = current_tutorial == 0
		
		
# changes dispalyed tutorial by -1 (last tutorial)
func _on_back_button_pressed() -> void:
	if current_tutorial > 0:
		current_tutorial -= 1
		show_tutorial()

# changes displayed tutorial by 1 (next tutorial)
# Transitions to main game when there are no more tutorials 
func _on_next_button_pressed() -> void:
	if current_tutorial < tutorials.size() - 1:
		current_tutorial += 1
		show_tutorial()
	else:
		SceneTransition.change_scene("res://scenes/main.tscn")
