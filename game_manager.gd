# GAME MANAGER AUTOLOAD SCRIPT

extends Node

# variables
var survival_time = 0
var game_active = false

# sets variables at the start of game
func start_game():
	survival_time = 0
	game_active =  true

# sets variable when game stopped
func stop_game():
	game_active = false

# sets variables when game resets
func reset_game():
	survival_time = 0
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
