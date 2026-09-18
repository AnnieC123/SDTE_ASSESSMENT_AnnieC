# ENEMY SPAWNER 
extends Node2D

# Variables
@onready var timer = $Timer
@onready var gui = $"../CanvasLayer/gui"
var player
var camera

# Loading in the enemies
var slime = preload("res://scenes/enemies/slime.tscn")
var skeleton = preload("res://scenes/enemies/skeleton.tscn")
var bat = preload("res://scenes/enemies/bat.tscn")

# waves
var waves = [
	[slime],
	[slime, slime, skeleton, bat],
	[slime, slime, slime, skeleton, skeleton, bat, bat]
]

# waves variables
var current_wave = 0
var enemies_to_spawn = 0
var enemies_alive = 0
var enemy_index = 0
var wave_delay = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	camera = player.get_node("Camera2D")
	enemies_to_spawn = waves[current_wave].size()
	
	print(gui) # debugging
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
	else:
		timer.stop()
		
		
# Spawns the enemy by creating a new instance, picking a random spawn point, then adding the enemy instance as a child to that position
func spawn_enemy():
	#checks if there are still more waves
	if current_wave <= waves.size():
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
	
	if enemies_alive <= 0:
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
		return
	
	enemy_index = 0
	enemies_to_spawn = waves[current_wave].size()
	
	gui.show_wave(current_wave + 1)
	timer.start()






# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
