# LEVEL TRANSITION (SAYS LEVEL #)
extends Control

@onready var level_label = $level_label

# changes text, then waits 1.5 second before transitioning to next level scene
func _ready() -> void:
	CursorManager.set_pointer()
	AudioManager.stop_bgm()

	level_label.text = "LEVEL " + str(GameManager.transition_level_number)
	await get_tree().create_timer(2).timeout
	SceneTransition.change_scene(GameManager.transition_next_scene)
