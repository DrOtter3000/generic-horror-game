extends task_interactor

func interact() -> void:
	super()
	player.working = true
	player.fade_out()
	await get_tree().create_timer(1.5).timeout
	get_tree().change_scene_to_file("res://Levels/laundry.tscn")
