# UPGRADE_MENU
extends Control

# preload the icons
var speed_icon = preload("res://assets/gui/icon_speed.png")
var health_icon = preload("res://assets/gui/icon_heal.png")
var attack_icon = preload("res://assets/gui/icon_attack.png")
var cooldown_icon = preload("res://assets/gui/icon_cooldown.png")

# Imports each upgrade name, description, and icon nodes
@onready var upgrade_1_name = $upgrades_container/upgrade_1/VBoxContainer/upgrade_name
@onready var upgrade_1_desc = $upgrades_container/upgrade_1/VBoxContainer/upgrade_description
@onready var upgrade_1_icon = $upgrades_container/upgrade_1/VBoxContainer/upgrade_icon

@onready var upgrade_2_name = $upgrades_container/upgrade_2/VBoxContainer/upgrade_name
@onready var upgrade_2_desc = $upgrades_container/upgrade_2/VBoxContainer/upgrade_description
@onready var upgrade_2_icon = $upgrades_container/upgrade_2/VBoxContainer/upgrade_icon

@onready var upgrade_3_name = $upgrades_container/upgrade_3/VBoxContainer/upgrade_name
@onready var upgrade_3_desc = $upgrades_container/upgrade_3/VBoxContainer/upgrade_description
@onready var upgrade_3_icon = $upgrades_container/upgrade_3/VBoxContainer/upgrade_icon


# Upgrades list:
var upgrades = [
	"speed",
	"health",
	"attack",
	"cooldown"
] 
# variables
var upgrade_choices =[]
var player



# Gets the upgrade name depending on which upgrade it is
func get_upgrade_name(upgrade):
	if upgrade == "speed":
		return "SPEED UP"
	if upgrade == "health":
		return "HEAL"
	if upgrade == "attack":
		return "ATTACK UP"
	if upgrade == "cooldown":
		return "COOLDOWN"
	
# Gets the upgrade description depending on which upgrade it is	
func get_upgrade_description(upgrade):
	if upgrade == "speed":
		return "Increases player movement speed"
	if upgrade == "health":
		return "Restores one heart"
	if upgrade == "attack":
		return "Increases bullet damage by 1"
	if upgrade == "cooldown":
		return "Reduce bullet cooldown by 10%"

# returns the icon depending on each upgrade
func get_upgrade_icon(upgrade):
	if upgrade == "speed":
		return speed_icon
	if upgrade == "health":
		return health_icon
	if upgrade == "attack":
		return attack_icon
	if upgrade == "cooldown":
		return cooldown_icon
	
	
# Picks 3 random upgrades and shows them on the menu
func show_upgrades():
	var available_upgrades = upgrades.duplicate()
	upgrade_choices.clear()
	
	# pick 3 random upgrades, adds them to the upgrade_chioces and removes it from available upgrades
	for i in 3:
		var random_upgrade = available_upgrades.pick_random()
		upgrade_choices.append(random_upgrade)
		available_upgrades.erase(random_upgrade)
	
	# Sets the name and description of each upgrade card
	upgrade_1_name.text = get_upgrade_name(upgrade_choices[0])
	upgrade_1_desc.text = get_upgrade_description(upgrade_choices[0])
	upgrade_1_icon.texture = get_upgrade_icon(upgrade_choices[0])
	
	upgrade_2_name.text = get_upgrade_name(upgrade_choices[1])
	upgrade_2_desc.text = get_upgrade_description(upgrade_choices[1])
	upgrade_2_icon.texture = get_upgrade_icon(upgrade_choices[1])

	upgrade_3_name.text = get_upgrade_name(upgrade_choices[2])
	upgrade_3_desc.text = get_upgrade_description(upgrade_choices[2])
	upgrade_3_icon.texture = get_upgrade_icon(upgrade_choices[2])


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _on_button_1_pressed() -> void:
	print("button 1 pressed") #debugging
	choose_upgrade(upgrade_choices[0])

func _on_button_2_pressed() -> void:
	print("button 2 pressed") #debugging
	choose_upgrade(upgrade_choices[1])

func _on_button_3_pressed() -> void:
	print("button 3 pressed") #debugging
	choose_upgrade(upgrade_choices[2])

# Applies the upgrade to the player
func choose_upgrade(upgrade):
	if upgrade == "speed":
		player.player_speed *= 1.25
	if upgrade == "health":
		player.player_health = min(player.player_health + 1, 3)
		player.gui.update_hearts(player.player_health)
	if upgrade == "attack":
		player.bullet_damage += 1
	if upgrade == "cooldown":
		player.bullet_cooldown *= 0.9
		
	hide()
	get_tree().paused = false
