# BASE ENEMY SCENE

extends CharacterBody2D
signal enemy_died

# Expoted Variables
@export var enemy_speed = 25
@export var enemy_health = 3
@export var enemy_cooldown = 1
@export var enemy_xp_drop = 1

# Other variables
var player
@onready var animated_sprite = $AnimatedSprite2D
var xp_scene = preload("res://scenes/xp.tscn")
@onready var navigation_agent = $NavigationAgent2D

func _ready():
	# Runs when the node enters the tree for the first time
	player = get_tree().get_first_node_in_group("player")
	animated_sprite.play("idle")

func _physics_process(_delta):
	# Tracks the player
	if player:
		navigation_agent.target_position = player.global_position
		var next_position = navigation_agent.get_next_path_position()

		
		var direction = (next_position - global_position).normalized()
		velocity = direction * enemy_speed
		
		# checks if the sprite needs to be flipped
		if player.global_position.x < global_position.x:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false
			
		move_and_slide()

# Reduces the enemy's health + spawn XP when the enemy dies
func enemy_take_damage(damage):
	enemy_health -= damage # minus the health variable by the damage amount
	
	# Deletes this enemy instance when its health reaches 0 
	if enemy_health <= 0:
		
		# SPAWNING XP:
		for i in enemy_xp_drop:
			var xp = xp_scene.instantiate()
			xp.xp_amount = 1
			
			xp.global_position = global_position
			
			var popout_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
			xp.popout_direction = popout_direction
			
			#var offset = Vector2(randf_range(-10, 10), randf_range(-10, 10))
			#xp.global_position = global_position + offset
			get_tree().current_scene.call_deferred("add_child", xp)
		
		# makes enemy instance disappear
		enemy_died.emit()
		queue_free()


var can_damage_player = true
func _on_area_2d_body_entered(body: Node2D) -> void:
	# Checks if the damage cooldown is over
	if body.has_method("player_take_damage") and can_damage_player == true:
		body.player_take_damage()
		
		# Makes it so there is a cooldown to dmg the player again
		can_damage_player = false
		await get_tree().create_timer(enemy_cooldown).timeout
		can_damage_player = true
		
