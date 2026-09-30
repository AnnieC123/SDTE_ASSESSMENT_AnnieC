# MAIN SCENE

extends Node2D

@onready var pause_menu = $CanvasLayer/pause_menu
@onready var upgrade_menu = $CanvasLayer/upgrade_menu
@onready var settings_menu = $CanvasLayer/settings_menu
@onready var enemy_spawner = $enemy_spawner

@export var level_number = 1

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

# IS CALLED BEFORE _ready():
func _enter_tree() -> void:
	# resets game if the level is 1
	if level_number == 1:
		GameManager.start_game()

# Sets bgm and cursor to crosshair on ready
func _ready() -> void:
	CursorManager.set_crosshair()
	
	if level_number == 1 or level_number == 2:
		AudioManager.play_bgm(AudioManager.main_bgm)
	elif level_number == 3:
		AudioManager.play_bgm(AudioManager.boss_bgm)
		
	enemy_spawner.level_completed.connect(on_level_completed)


# gets the change scene variables dpending on which level it is
func on_level_completed():
	if level_number == 1:
		GameManager.transition_level_number = 2
		GameManager.transition_next_scene = "res://scenes/level_2.tscn"
		SceneTransition.change_scene("res://scenes/gui/level_transition.tscn")
	elif level_number == 2:
		GameManager.transition_level_number = 3
		GameManager.transition_next_scene = "res://scenes/level_3.tscn"
		SceneTransition.change_scene("res://scenes/gui/level_transition.tscn")
	elif level_number == 3:
		GameManager.stop_game()
		SceneTransition.change_scene("res://scenes/gui/win_screen.tscn")
