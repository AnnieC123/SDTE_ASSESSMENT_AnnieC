# MAIN MENU

extends Control

# Sets bgm and cursor to pointer
func _ready() -> void:
	AudioManager.play_bgm(AudioManager.menu_bgm)
	CursorManager.set_pointer()

# Changes scene to main game when pressed
func _on_play_button_pressed() -> void:
	AudioManager.play_sfx(AudioManager.click)
	SceneTransition.change_scene("res://scenes/gui/tutorial.tscn")

# Shows the settings overlay when pressed
func _on_settings_button_pressed() -> void:
	$settings_menu.open()
	
# Changes to credtis screen when pressed
func _on_credits_button_pressed() -> void:
	pass
	# Switch to credits screen
