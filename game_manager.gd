# GAME MANAGER AUTOLOAD SCRIPT
extends Node

# variables
var survival_time = 0
var game_active = false

# PLAYER STATS
var player_health = 6
var player_level = 1
var player_xp = 0
var player_xp_required = 1
var player_speed = 50
var bullet_cooldown = 1
var bullet_damage = 1

# level transition variables
var transition_level_number = 1
var transition_next_scene = "res://scenes/level_1.tscn"


# sets variables at the start of game
func start_game():
	survival_time = 0
	game_active =  true
	
	# Resets ALL PLAYER STATS back to deafult
	player_health = 6
	player_level = 1
	player_xp = 0
	player_xp_required = 1

	player_speed = 50
	bullet_cooldown = 1
	bullet_damage = 1

# sets variable when game stopped
func stop_game():
	game_active = false

# gets the survival time in minutes and seconds, and returns it
func get_survival_time():
	var total_seconds = int(survival_time)
	var minutes = total_seconds / 60
	var seconds = total_seconds % 60
	
	return "%02d:%02d" % [minutes, seconds]

# adds time to the survival_time varaibles
func _process(delta: float) -> void:
	if game_active == true and not get_tree().paused:
		survival_time += delta
