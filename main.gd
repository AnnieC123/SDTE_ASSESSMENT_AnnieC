# MAIN SCENE

extends Node2D

@onready var pause_menu = $CanvasLayer/pause_menu
@onready var upgrade_menu = $CanvasLayer/upgrade_menu
	
	# detects when the player presses the esc key
func _input(event):
	if upgrade_menu.visible:
		return
	if event.is_action_pressed("esc"):
		# hides menu
		if get_tree().paused:
			get_tree().paused = false
			pause_menu.hide()
		# shows menu
		else:
			get_tree().paused =  true
			pause_menu.show()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
