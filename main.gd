# MAIN SCENE

extends Node2D

@onready var pause_menu = $CanvasLayer/pause_menu
@onready var upgrade_menu = $CanvasLayer/upgrade_menu
@onready var settings_menu = $CanvasLayer/settings_menu

	# detects when the player presses the esc key
func _input(event):
	# Checks first if other menu's are visible (on top)
	if upgrade_menu.visible:
		return
	if settings_menu.visible:
		return
		
	if event.is_action_pressed("esc"):
		# hides menu
		if get_tree().paused:
			get_tree().paused = false
			pause_menu.hide()
			CursorManager.set_crosshair()

		# shows menu
		else:
			get_tree().paused =  true
			pause_menu.show()
			CursorManager.set_pointer()

# Sets bgm and cursor to crosshair on ready
func _ready() -> void:
	AudioManager.play_bgm(AudioManager.main_bgm)
	CursorManager.set_crosshair()
	GameManager.start_game()

	
	
