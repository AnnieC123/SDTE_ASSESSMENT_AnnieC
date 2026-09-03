# XP

extends Area2D

# Variables
@export var xp_amount = 1
var popout_direction = Vector2.ZERO
var popout_distance = 5

# Uses tween to animate the popout effect of the XP.
func _ready() -> void:
	var target_position = position + popout_direction * popout_distance
	var tween = create_tween()
	tween.tween_property(self, "position", target_position, 0.3)
	
func _process(_delta: float) -> void:
	pass

# Detects when the player (which has gain_xp method) touches the XP
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("gain_xp"):
		body.gain_xp(xp_amount)
		queue_free()
		
