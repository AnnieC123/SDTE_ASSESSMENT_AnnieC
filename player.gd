# PLAYER

extends CharacterBody2D

# Player variables
@export var player_speed = 75
@export var player_health = 3
var player_level = 1
var player_xp = 0
var player_xp_required = 1
@onready var animated_sprite = $AnimatedSprite2D

# Bullet varaibles
var bullet_scene = preload("res://scenes/bullet.tscn")
var bullet_cooldown = 1
var bullet_damage = 1
var bullet_modifier = "none"

# GUI varaibles
@onready var gui = $"../CanvasLayer/gui"
@onready var upgrade_menu = $"../CanvasLayer/upgrade_menu"

# sets up how the palyer appears in the game
func _ready():
	print("ready") # debugging
	animated_sprite.play("idle")
	print(player_speed) #print for debugging
	gui.update_hearts(player_health)

	# Handles automatic shooting
	while true:	
		# waits for however long the bullet_cooldown varaible is before shooting
		await get_tree().create_timer(bullet_cooldown, false).timeout

		# Checks if the game is paused before shooting
		if not get_tree().paused:
			shoot_bullet()

# get's the keyboard input of the player
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * player_speed

func shoot_bullet():
	# Creates a new instance of the 'bullet' scene
	var  bullet = bullet_scene.instantiate()	
	# Sets position and direction of the bullet to the position/direction of the player
	bullet.bullet_direction = ((get_global_mouse_position() - global_position)).normalized()
	bullet.global_position = global_position + bullet.bullet_direction * 8
	bullet.bullet_damage = bullet_damage
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

# Function calls every frame, moves player and handles player rotation
func _physics_process(_delta):
	# Flips
	if get_global_mouse_position().x > global_position.x:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
	get_input()
	move_and_slide()

# Called everytime the player takes damage and updates health
func player_take_damage():
	player_health -= .5
	print("Player health:", player_health)
	gui.update_hearts(player_health)
	
	if player_health <= 0:
		print("Game Over")
		queue_free()

# Is called when he player touches the xp
func gain_xp(xp_amount):
	player_xp += xp_amount
	
	# update the xp bar
	gui.update_xp_bar(player_xp, player_xp_required)
	
	# Checks if the player levels up
	if player_xp >= player_xp_required:
		level_up()
	
# Handles player level up	
func level_up():
	player_level += 1
	player_xp = 0
	player_xp_required += 2
	print("Level up") # Debugging
	
	# Updates progress XP bar
	gui.update_xp_bar(player_xp, player_xp_required)

	# pauses game then shows upgrade screen
	get_tree().paused = true

	upgrade_menu.show_upgrades()
	upgrade_menu.show()
	
	
