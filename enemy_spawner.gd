extends Node2D

# Variables
var enemy_scene = preload("res://scenes/enemies/slime.tscn")
@onready var timer = $Timer
var spawn_points = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Adds markers to the spawn_points list
	spawn_points = [$Marker2D, $Marker2D2, $Marker2D3, $Marker2D4]

	timer.start()
	
func _on_timer_timeout() -> void:
	# Calls the spawn_enemy() function when the timer runs out
	spawn_enemy()
		
func spawn_enemy():
	# Spawns the enemy by creating a new instance, picking a random spawn point, then adding the enemy instance as a child to that position
	var enemy = enemy_scene.instantiate()
	var spawn_point = spawn_points.pick_random()
	enemy.global_position = spawn_point.global_position
	get_tree().current_scene.add_child(enemy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
