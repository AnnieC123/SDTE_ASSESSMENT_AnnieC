# SETTINGS MENU
extends Control

#buttons
@onready var  bgm_checkbox = $VBoxContainer/checkbox_bgm
@onready var sfx_checkbox = $VBoxContainer/checkbox_sfx
@onready var screenshake_checkbox = $VBoxContainer/checkbox_screenshake

# Turns all settings on at the start, also sets colour and size
func _ready():
	scale = Vector2(0.9, 0.9)
	modulate = Color(1, 1, 1, 0)
	
	bgm_checkbox.button_pressed = AudioManager.bgm_enabled
	sfx_checkbox.button_pressed = AudioManager.sfx_enabled
	screenshake_checkbox.button_pressed = AudioManager.screenshake_enabled

# opens menu and animates using tween
func open():
	show()
	
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 0.25)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.25)
	
# closes menu and animates using tween
func close():
	var tween = create_tween()
	tween.set_parallel()
	tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 0.2)
	tween.tween_property(self, "scale", Vector2(0.9, 0.9), 0.2)
	
	await tween.finished
	hide()


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
	close()
