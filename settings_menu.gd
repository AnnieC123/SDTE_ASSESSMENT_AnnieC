# SETTINGS MENU
extends Control

#buttons
@onready var  bgm_checkbox = $VBoxContainer/checkbox_bgm
@onready var sfx_checkbox = $VBoxContainer/checkbox_sfx
@onready var screenshake_checkbox = $VBoxContainer/checkbox_screenshake

# Turns all settings on at the start
func _ready():
	bgm_checkbox.button_pressed = AudioManager.bgm_enabled
	sfx_checkbox.button_pressed = AudioManager.sfx_enabled
	screenshake_checkbox.button_pressed = AudioManager.screenshake_enabled

# Background music checkbox
func _on_checkbox_bgm_toggled(toggled_on: bool) -> void:
	AudioManager.set_bgm_enabled(toggled_on)

# Sound effect checkbox
func _on_checkbox_sfx_toggled(toggled_on: bool) -> void:
	AudioManager.set_sfx_enabled(toggled_on)

# Screen shake checkbox
func _on_checkbox_screenshake_toggled(toggled_on: bool) -> void:
	AudioManager.set_screenshake_enabled(toggled_on)
	
# Hides when the back button is pressed
func _on_back_button_pressed() -> void:
	hide()
