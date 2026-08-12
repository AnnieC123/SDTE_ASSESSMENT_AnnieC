extends CharacterBody2D

# Variables
@export var player_speed = 75
@export var player_health = 3

var bullet_scene = preload("res://scenes/bullet.tscn")
var bullet_cooldown = 1

@onready var animated_sprite = $AnimatedSprite2D


func _ready():
	print("ready")
	animated_sprite.play("idle")
	print(player_speed) #print for debugging
	
	# Handles automatic shooting
	while true:	
		# waits for however long the bullet_cooldown varaible is before shooting
		await get_tree().create_timer(bullet_cooldown).timeout
		shoot_bullet()
	
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * player_speed

func shoot_bullet():
	# Creates a new instance of the 'bullet' scene
	var  bullet = bullet_scene.instantiate()	
	print(bullet) #Prints out message (for testing)
	# Sets position and direction of the bullet to the position/direction of the player
	bullet.global_position = global_position
	bullet.bullet_direction = ((get_global_mouse_position() - global_position)).normalized()
	# Adds bullet to the scene
	get_tree().current_scene.add_child(bullet)
	
## CLICK TO SHOOT FUNCTION:
#func _input(event):
	## Detects if there is a mouse click
	#if event.is_action_pressed("mouse_click"):
		## Creates a new instance of the bullet scene
		#var bullet = bullet_scene.instantiate()
		#print(bullet)
		#bullet.global_position = global_position
		## Get the bullet direction
		#bullet.bullet_direction = (get_global_mouse_position() - global_position).normalized()
		#get_tree().current_scene.add_child(bullet)

func _physics_process(_delta):
	# Flips
	if get_global_mouse_position().x > global_position.x:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
	get_input()
	move_and_slide()
	
func player_take_damage():
	player_health -= 1
	print("Player health:", player_health)
	
	if player_health <= 0:
		print("Game Over")
		queue_free()
	
