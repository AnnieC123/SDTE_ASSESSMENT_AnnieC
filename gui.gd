# GUI

extends Control

# Variables
@onready var wave_label = $wave_label
@onready var animation_player = $AnimationPlayer

# Shows the "WAVE #" on the screen while doing a fading animation of it
func show_wave(wave_number):
	wave_label.text = "WAVE " + str(wave_number)
	animation_player.play("wave_transition")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
