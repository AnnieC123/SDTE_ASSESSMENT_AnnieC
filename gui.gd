# GUI

extends Control

# Variables
@onready var wave_label = $wave_label
@onready var animation_player = $AnimationPlayer
@onready var xp_bar = $xpbar

# Hearts
@onready var heart1 = $hearts/heart1
@onready var heart2 = $hearts/heart2
@onready var heart3 = $hearts/heart3
var full_heart = 0
var damaged_heart = 1
var half_heart = 2
var damaged_half_heart = 3
var empty_heart = 4

func update_hearts(health):
	if health >= 3:
		heart1.frame = full_heart
		heart2.frame = full_heart
		heart3.frame = full_heart
		
	elif health == 2.5:
		heart1.frame = full_heart
		heart2.frame = full_heart
		heart3.frame = half_heart
		
	elif health == 2:
		heart1.frame = full_heart
		heart2.frame = full_heart
		heart3.frame = empty_heart
		
	elif health == 1.5:
		heart1.frame = full_heart
		heart2.frame = half_heart
		heart3.frame = empty_heart
		
	elif health == 1:
		heart1.frame = full_heart
		heart2.frame = empty_heart
		heart3.frame = empty_heart
		
	elif health == 0.5:
		heart1.frame = half_heart
		heart2.frame = empty_heart
		heart3.frame = empty_heart
		
	else:
		heart1.frame = empty_heart
		heart2.frame = empty_heart
		heart3.frame = empty_heart
	




# Shows the "WAVE #" on the screen while doing a fading animation of it
func show_wave(wave_number):
	wave_label.text = "WAVE " + str(wave_number)
	animation_player.play("wave_transition")

# Updates the xp bar progress
func update_xp_bar(current_xp, required_xp):
	xp_bar.value = current_xp
	xp_bar.max_value = required_xp



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
