# CURSOR MANAGER
extends Node

var crosshair = preload("res://assets/gui/big_cursor_crosshair.png")
var pointer = preload("res://assets/gui/big_cursor_pointer.png")

# Sets the cursor to crosshair
func set_crosshair():
	Input.set_custom_mouse_cursor(crosshair, Input.CURSOR_ARROW, Vector2(7,7))

# Sets the cursor to pointer
func set_pointer():
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_ARROW, Vector2(0,0))
