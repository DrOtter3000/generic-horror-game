extends Node3D

@onready var options: CanvasLayer = $Options


func _ready() -> void:
	options.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/home.tscn")

func _on_back_to_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")

func _on_menu_timer_timeout() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	options.show()
