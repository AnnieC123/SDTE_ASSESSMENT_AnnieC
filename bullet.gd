extends Area2D

@export var bullet_speed = 125
var bullet_direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	look_at(get_global_mouse_position())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += bullet_direction * bullet_speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("enemy_take_damage"):
		body.enemy_take_damage()
		queue_free()
