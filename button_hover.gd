# REUSABLE BUTTON HOVER SCRIPT + BUTTON PRESSED SFX
extends Button

# Connects the signals
func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)

	pivot_offset = size / 2

# When mouse enters, plays sound effect and makes button larger
func _on_mouse_entered():
	AudioManager.play_sfx(AudioManager.hover)
	scale = Vector2(1.1, 1.1)

# When mouse leaves, changes size back
func _on_mouse_exited():
	scale = Vector2(1, 1)

# When button pressed, plays sound effect
func _on_pressed():
	AudioManager.play_sfx(AudioManager.click)
