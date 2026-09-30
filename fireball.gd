# FIREBALL
extends Area2D

@export var fireball_speed = 125
var fireball_direction = Vector2.ZERO
var fireball_damage = 2

@onready var animated_sprite = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += fireball_direction * fireball_speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("boss"):
		return

	if body.has_method("player_take_damage"):
		body.player_take_damage(fireball_damage)
	queue_free()
