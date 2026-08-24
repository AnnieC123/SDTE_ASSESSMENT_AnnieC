extends Node2D

# Variables
@onready var timer = $Timer
var player
var camera

#Enemies
var slime = preload("res://scenes/enemies/slime.tscn")
var skeleton = preload("res://scenes/enemies/skeleton.tscn")

# Lists
var enemies_list = []
#var spawn_points = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	camera = player.get_node("Camera2D")
	enemies_list = [slime, skeleton]
	timer.start()

	# Adds markers to the spawn_points list
	#spawn_points = [$Marker2D, $Marker2D2, $Marker2D3, $Marker2D4]
	
	
# Calls the spawn_enemy() function when the timer runs out	
func _on_timer_timeout() -> void:
	# checks if the player(camera) still exists
	if is_instance_valid(camera):
		spawn_enemy()
		
		
func spawn_enemy():
	# Spawns the enemy by creating a new instance, picking a random spawn point, then adding the enemy instance as a child to that position
	var enemy = enemies_list.pick_random().instantiate()
	enemy.global_position = get_spawn_position()
	get_tree().current_scene.add_child(enemy)
	
	#___ old script with 2DMarkers ____________________
	#var spawn_point = spawn_points.pick_random()
	#enemy.global_position = spawn_point.global_position
	
	
func get_spawn_position():
	# Gets the spawn position of the enemy, just outside the camera range
	var camera_position = camera.global_position
	
	var viewport_size = get_viewport_rect().size
	var half_width = viewport_size.x / 2
	var half_height = viewport_size.y / 2
	var spawn_distance = 20
	
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











# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
