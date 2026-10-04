# PAUSE MENU
extends Control

# stat labels:
@onready var attack_label = $HBoxContainer/stats_vbox/attack_hbox/Label
@onready var speed_label = $HBoxContainer/stats_vbox/speed_hbox/Label
@onready var cooldown_label = $HBoxContainer/stats_vbox/cooldown_hbox/Label

func update_stats():
	attack_label.text = "Attack: " + str(GameManager.bullet_damage)
	speed_label.text = "Speed: " + str(GameManager.player_speed)
	cooldown_label.text = "Cooldown: " + str(snapped(GameManager.bullet_cooldown, 0.01)) + "s"

# Unpauses the game
func _on_resume_button_pressed() -> void:
	CursorManager.set_crosshair()
	hide()
	get_tree().paused = false

# Changes to settings screen
func _on_settings_button_pressed() -> void:
	$"../settings_menu".open()
	
# Changes to main menu screen
func _on_menu_button_pressed() -> void:
	SceneTransition.change_scene("res://scenes/gui/main_menu.tscn")
	get_tree().paused = false
	
