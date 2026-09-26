# DEATH SCREEN

extends Control

@onready var time_survived_label = $time_survived

# Sets cursor to pointer and gets time
func _ready() -> void:
	CursorManager.set_pointer()
	time_survived_label.text = "Time Survived: " + GameManager.get_survival_time()

# change scene to main menu
func _on_menu_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/gui/main_menu.tscn")

# change scene to main game level 1
func _on_retry_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/main.tscn")
