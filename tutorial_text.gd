# TUTORIAL TEXT SCRIPT
# under the level 1 (main) scene
extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(3, false).timeout
	text = "Tutorial- Aiming and shooting:\nMove your mouse to aim."
	
	await get_tree().create_timer(3, false).timeout
	text = "Tutorial- Leveling up:\nTouch the XP that the enemy drops to collect it."

	await get_tree().create_timer(3, false).timeout
	text = "Press the escape key to pause."

	await get_tree().create_timer(3, false).timeout
	text = "Good luck!"
	
	await get_tree().create_timer(3, false).timeout
	text = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
