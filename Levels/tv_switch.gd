extends Interactor

func interact() -> void:
	get_tree().call_group("TV", "tv_noise", false)
	hide_creature()
	queue_free()

func hide_creature() -> void:
	get_tree().call_group("Creature", "queue_free")
