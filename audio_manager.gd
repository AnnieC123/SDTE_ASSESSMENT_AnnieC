# AUDIO MANAGER + screenshake
extends Node

@onready var bgm = $bgm
@onready var sfx = $sfx

# sets sounds to be on by default
var sfx_enabled = true
var bgm_enabled = true
var screenshake_enabled = true

# background music:
var menu_bgm = preload("res://assets/sound/bgm/bgm_menu.ogg")
var main_bgm = preload("res://assets/sound/bgm/bgm_main.ogg")
var boss_bgm = preload("res://assets/sound/bgm/bgm_boss.ogg")

# sound effects:
var xp_pickup = preload("res://assets/sound/sfx/sfx_xppickup.wav")
var shoot_bullet = preload("res://assets/sound/sfx/sfx_shoot.wav")
var take_dmg = preload("res://assets/sound/sfx/sfx_takedmg.wav")
var enemy_take_dmg = preload("res://assets/sound/sfx/sfx_enemy_takedmg.wav")
var level_up = preload("res://assets/sound/sfx/sfx_levelup.wav")
var click = preload("res://assets/sound/sfx/sfx_click.wav")
var hover = preload("res://assets/sound/sfx/sfx_hover.wav")

# plays the specific backgrond music when called
func play_bgm(background_music):
	if bgm_enabled:
		bgm.stream = background_music
		bgm.play()

func stop_bgm():
	bgm.stop()

# plays the specific sound effect when called
func play_sfx(sound_effect):
	if sfx_enabled:
		sfx.stream = sound_effect
		sfx.play()


# turns bgm on/off
func set_bgm_enabled(enabled):
	bgm_enabled = enabled
	if bgm_enabled:
		bgm.play()
	else:
		bgm.stop()
	
# turns sfx on/off
func set_sfx_enabled(enabled):
	sfx_enabled = enabled

# turns screenshake on/off
func set_screenshake_enabled(enabled):
	screenshake_enabled = enabled
	
