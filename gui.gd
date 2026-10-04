# GUI

extends Control

# Variables
@onready var wave_label = $wave_label
@onready var animation_player = $AnimationPlayer
@onready var xp_bar = $xpbar
@onready var level_display = $xpbar/level_display
@onready var damage_effect = $damage_effect

# Hearts
@onready var heart1 = $hearts/heart1
@onready var heart2 = $hearts/heart2
@onready var heart3 = $hearts/heart3
var full_heart = 0
var damaged_heart = 1
var half_heart = 2
var damaged_half_heart = 3
var empty_heart = 4

# updates hearts correspondingly
func update_hearts(health):
	if health >= 6:
		heart1.frame = full_heart
		heart2.frame = full_heart
		heart3.frame = full_heart
		
	elif health == 5:
		heart1.frame = full_heart
		heart2.frame = full_heart
		heart3.frame = half_heart
		
	elif health == 4:
		heart1.frame = full_heart
		heart2.frame = full_heart
		heart3.frame = empty_heart
		
	elif health == 3:
		heart1.frame = full_heart
		heart2.frame = half_heart
		heart3.frame = empty_heart
		
	elif health == 2:
		heart1.frame = full_heart
		heart2.frame = empty_heart
		heart3.frame = empty_heart
		
	elif health == 1:
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
	
# Updates the level displayer
func update_level_display(level):
	level_display.text = "Level " + str(level)

func show_damage_effect():
	print("show damage effect")
	damage_effect.modulate.a = 0.5
	var tween = create_tween()
	tween.tween_property(damage_effect, "modulate:a", 0.0, 0.3)
	
# makes the damage effect invisible at the start
func _ready() -> void:
	damage_effect.modulate.a = 0
