# PAUSE MENU
extends Control

# Unpauses the game
func _on_resume_button_pressed() -> void:
	AudioManager.play_sfx(AudioManager.click)
	CursorManager.set_crosshair()
	hide()
	get_tree().paused = false

# Changes to settings screen
func _on_settings_button_pressed() -> void:
	AudioManager.play_sfx(AudioManager.click)
	$"../settings_menu".show()
	
# Changes to main menu screen
func _on_menu_button_pressed() -> void:
	AudioManager.play_sfx(AudioManager.click)
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/gui/main_menu.tscn")
