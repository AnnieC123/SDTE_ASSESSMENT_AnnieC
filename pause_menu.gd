# PAUSE MENU
extends Control

# Unpauses the game
func _on_resume_button_pressed() -> void:
	CursorManager.set_crosshair()
	hide()
	get_tree().paused = false

# Changes to settings screen
func _on_settings_button_pressed() -> void:
	$"../settings_menu".open()
	
# Changes to main menu screen
func _on_menu_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/gui/main_menu.tscn")
	get_tree().paused = false
	
