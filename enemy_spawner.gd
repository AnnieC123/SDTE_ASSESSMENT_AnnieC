# ENEMY SPAWNER 
extends Node2D

signal level_completed

# Variables
@onready var timer = $Timer
@onready var gui = $"../CanvasLayer/gui"
var player
var camera

@export var level_number = 1

# Loading in the enemies
var slime = preload("res://scenes/enemies/slime.tscn")
var skeleton = preload("res://scenes/enemies/skeleton.tscn")
var bat = preload("res://scenes/enemies/bat.tscn")
var zombie = preload("res://scenes/enemies/zombie.tscn")
var dragon = preload("res://scenes/enemies/dragon.tscn")
var boss = preload("res://scenes/enemies/boss.tscn")

# waves for each level
var waves = []

# waves variables
var current_wave = 0
var enemies_to_spawn = 0
var enemies_alive = 0
var enemy_index = 0
var wave_delay = 2
var wave_completing = false
var spawning_finished = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# SETS WAVE depending on which level it is:
	if level_number == 1:
		waves = [
		[slime],
		[slime, slime, skeleton],
		[slime, slime, skeleton, skeleton, bat, bat]
		]
	elif level_number == 2:
		waves = [
			[skeleton, bat, skeleton, bat, zombie],
			[bat, bat, bat, bat, zombie, zombie, zombie, dragon],
			[slime, slime, slime, skeleton, skeleton, bat, bat, zombie, zombie, dragon, dragon]
		]
	elif level_number == 3:
		waves = [
			[boss]
		]

	
	player = get_tree().get_first_node_in_group("player")
	camera = player.get_node("Camera2D")
	
	enemies_to_spawn = waves[current_wave].size()
	spawning_finished = false
	# shows wave number
	gui.call_deferred("show_wave", current_wave + 1)
	timer.start()
	
	
# Calls the spawn_enemy() function when the timer runs out	
func _on_timer_timeout() -> void:
	# checks if the player(camera) still exists
	if is_instance_valid(camera):
		spawn_enemy()
		
		# Stops if there's no more enemies to spawn in this wave
		if enemies_to_spawn <= 0:
			timer.stop()
			spawning_finished = true
	else:
		timer.stop()
		
		
# Spawns the enemy by creating a new instance, picking a random spawn point, then adding the enemy instance as a child to that position
func spawn_enemy():
	#checks if the current wave still exists
	if current_wave < waves.size():
		var enemy_scene = waves[current_wave][enemy_index]
		var enemy = enemy_scene.instantiate()
		
		enemy.global_position = get_spawn_position()
		get_tree().current_scene.add_child(enemy)
		
		# Calls the enemy_died function when it recieves the signal
		enemy.enemy_died.connect(enemy_died)
		enemy_index += 1
		enemies_to_spawn -= 1
		enemies_alive += 1
	
	
# Gets the spawn position of the enemy, just outside the camera range	
func get_spawn_position():
	var camera_position = camera.global_position
	
	# Viewport variables
	var viewport_size = get_viewport_rect().size
	var half_width = viewport_size.x / 2
	var half_height = viewport_size.y / 2
	var spawn_distance = 10
	
	var side = randi_range(0, 3)
	var spawn_position = camera_position
	
	if side == 0:
		# Top side
		spawn_position.x += randf_range(-half_width, half_width)
		spawn_position.y -= half_height + spawn_distance
	
	elif side == 1:
		# Bottom side
		spawn_position.x += randf_range(-half_width, half_width)
		spawn_position.y += half_height + spawn_distance
	
	elif side == 2:
		# Left side
		spawn_position.x -= half_width + spawn_distance
		spawn_position.y += randf_range(-half_height, half_height)
		
	else:
		# Right side
		spawn_position.x += half_width + spawn_distance
		spawn_position.y += randf_range(-half_height, half_height)
		
	return spawn_position


# Detects if the wave is complete after each enemy dies
func enemy_died():
	enemies_alive -= 1
	print("Enemy died- enemies alive:", enemies_alive) # Debugging

	if enemies_alive <= 0 and spawning_finished and not wave_completing:
		wave_completing = true
		print("Wave complete") # for debugging
		# Creates a timer for wave_delay seconds
		await get_tree().create_timer(wave_delay).timeout
		next_wave()


# Resets the varaibles for the next wave + starts the next wave
func next_wave():
	current_wave += 1
	
	# Checks if there are any more waves
	if current_wave >= waves.size():
		print("Level complete") # for debugging
		level_completed.emit()
		return
	
	enemy_index = 0
	wave_completing = false
	spawning_finished = false
	enemies_to_spawn = waves[current_wave].size()
	
	gui.show_wave(current_wave + 1)
	timer.start()
