extends Interactor

var last_level

func interact() -> void:
	if last_level:
		get_tree().change_scene_to_file("res://Menus/win_screen.tscn")
		return
	get_tree().call_group("TV", "tv_noise", false, 0)
	hide_creature()
	queue_free()

func hide_creature() -> void:
	get_tree().call_group("Creature", "queue_free")
