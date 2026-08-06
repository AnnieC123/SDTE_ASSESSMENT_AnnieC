extends CharacterBody2D

# Variables
@export var enemy_speed = 100
var enemy_health = 3
var player
@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	# Runs when the node enters the tree for the first time
	player = get_tree().get_first_node_in_group("player")
	animated_sprite.play("idle")

func _physics_process(delta):
	
	# Tracks the player
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * enemy_speed
		
		# checks if the sprite needs to be flipped
		if player.global_position.x < global_position.x:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false
			
		
		move_and_slide()
		
func enemy_take_damage():
	enemy_health -= 1 # minus the health variable by 1
	
	if enemy_health <= 0:
		queue_free()
		

var can_damage_player = true
func _on_area_2d_body_entered(body: Node2D) -> void:
	# Checks if the damage cooldown is over
	if body.has_method("player_take_damage") and can_damage_player == true:
		body.player_take_damage()
		
		# Makes it so theres a 1s cooldown to dmg the player again
		can_damage_player = false
		await get_tree().create_timer(1.0).timeout
		can_damage_player = true
		
