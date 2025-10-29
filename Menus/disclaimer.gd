extends Control

var last_message := false

@onready var label: Label = $MarginContainer/Label




func _on_timer_timeout() -> void:
	if last_message:
		get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
	last_message = true
	label.text = "This game was made in 10 days by a single otter for the GameDev.tv Halloween GameJam 2025. The GameJam version is still available on itch.io. In this version I only fixed a little bit of ambience."
