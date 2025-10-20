extends Control

@onready var continue_button: Button = $CenterContainer/VBoxContainer/MainLinks/ContinueButton
@onready var options = preload("res://Menus/options.tscn")


func _ready() -> void:
	AudioManager.horror_ambient_player.play()
	if Gamestate.played_through:
		continue_button.show()
	else:
		continue_button.hide()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/intro.tscn")

func _on_options_button_pressed() -> void:
	var options_instance = options.instantiate()
	add_child(options_instance)
	options_instance.is_in_main_menu = true

func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Menus/credits.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/home.tscn")
