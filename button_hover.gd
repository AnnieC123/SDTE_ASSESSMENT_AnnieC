# REUSABLE BUTTON HOVER SCRIPT
extends Button

# Connects the signals
func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pivot_offset = size / 2

# When mouse enters, plays sound effect and makes button larger
func _on_mouse_entered():
	AudioManager.play_sfx(AudioManager.hover)
	scale = Vector2(1.1, 1.1)

# When mouse leaves, changes size back
func _on_mouse_exited():
	scale = Vector2(1, 1)
