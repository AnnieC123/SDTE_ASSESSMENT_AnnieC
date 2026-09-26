# SCENE TRANSITION
extends CanvasLayer

@onready var animation_player = $AnimationPlayer

# fades out of black at the start
func _ready() -> void:
	animation_player.play("fade_out_black")

# Plays fade to black, then waits until the animation finishes, changes the scene, then plays fade out of black
func change_scene(scene_path):
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	
	get_tree().change_scene_to_file(scene_path)
	animation_player.play("fade_out_black")
