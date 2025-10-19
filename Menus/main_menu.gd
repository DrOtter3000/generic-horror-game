extends Control

@onready var continue_button: Button = $CenterContainer/VBoxContainer/MainLinks/ContinueButton

func _ready() -> void:
	if Gamestate.played_through:
		continue_button.show()
	else:
		continue_button.hide()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/intro.tscn")

func _on_options_button_pressed() -> void:
	pass # Replace with function body.

func _on_credits_button_pressed() -> void:
	pass # Replace with function body.

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/home.tscn")
