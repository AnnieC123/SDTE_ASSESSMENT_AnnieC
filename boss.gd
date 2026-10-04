# BOSS DRAGON
extends CharacterBody2D
signal enemy_died

# Boss stats
@export var boss_health = 100
@export var boss_damage = 2
@export var boss_speed = 40
@export var boss_cooldown = 1

var fireball_scene = preload("res://scenes/fireball.tscn")

@onready var animated_sprite = $AnimatedSprite2D
@onready var health_bar = $health_bar
@onready var fireball_timer = $fireball_timer
@onready var navigation_agent = $NavigationAgent2D

var player
var fireball_shot = false
var hit_effect_time = 0.1

# sets health on ready
func _ready() -> void:
	health_bar.max_value = boss_health
	health_bar.value = boss_health
	player = get_tree().get_first_node_in_group("player")
	animated_sprite.play("idle")
	

# moves the dragon boss + flips it directionally
func _physics_process(_delta):	
	if player:
		navigation_agent.target_position = player.global_position
		
		var next_position = navigation_agent.get_next_path_position()
		var direction = (next_position - global_position).normalized()
		
		velocity = direction * boss_speed
		move_and_slide()
		
		if player.global_position.x < global_position.x:
			animated_sprite.flip_h = true
		else:
			animated_sprite.flip_h = false


# Shoots the fireball when the boss's mouth is open (frame 1 of attack)
func _process(_delta: float) -> void:
	if animated_sprite.animation == "attack":
		if animated_sprite.frame == 1 and fireball_shot == false:
			fireball_shot = true
			shoot_fireball()


# creates an instance of the fireball scene and adds it to the current scene
func shoot_fireball():
		var fireball = fireball_scene.instantiate()
		# sets starting direction and position of fireball
		fireball.fireball_direction = (player.global_position - global_position).normalized()
		fireball.global_position = global_position + fireball.fireball_direction * 10
		
		get_tree().current_scene.add_child(fireball)


# plays the attack animation
func _on_fireball_timer_timeout() -> void:
	if player:
		fireball_shot = false
		animated_sprite.play("attack")
		

# When you attack the boss + emits enemy_died after it's killed
func enemy_take_damage(damage):
	boss_health -= damage
	show_hit_effect()
	health_bar.value = boss_health
	
	if boss_health <= 0:
		enemy_died.emit()
		AudioManager.play_sfx(AudioManager.enemy_take_dmg)
		queue_free()

# enemy flashes red when hit by bullet
func show_hit_effect(): 
	animated_sprite.modulate = Color(0.69, 0.29, 0.345)
	await get_tree().create_timer(hit_effect_time).timeout
	animated_sprite.modulate = Color.WHITE

# Changes the animation back to idle after it has finished attacking
func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "attack":
		animated_sprite.play("idle")

# Damage the player +cooldown
var can_damage_player = true
func _on_area_2d_body_entered(body: Node2D) -> void:
	# Checks if the damage cooldown is over
	if body.has_method("player_take_damage") and can_damage_player == true:
		body.player_take_damage(boss_damage)
		
		# Makes it so there is a cooldown to dmg the player again
		can_damage_player = false
		await get_tree().create_timer(boss_cooldown).timeout
		can_damage_player = true
