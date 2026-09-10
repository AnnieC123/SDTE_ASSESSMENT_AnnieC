# PAUSE MENU
extends Control

# Unpauses the game
func _on_resume_button_pressed() -> void:
	hide()
	get_tree().paused = false

# Changes to settings screen
func _on_settings_button_pressed() -> void:
	# CHANGE TO SETTINGS SCENE (TO BE ADDED)
	pass
	
# Changes to main menu screen
func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/gui/main_menu.tscn")
