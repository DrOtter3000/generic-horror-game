extends Control


func _on_timer_timeout() -> void:
	Gamestate.played_through = true
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")
