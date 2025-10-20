extends Control

func _ready() -> void:
	AudioManager.horror_ambient_player.stop()

func _on_timer_timeout() -> void:
	Gamestate.played_through = true
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
