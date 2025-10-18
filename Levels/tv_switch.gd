extends Interactor

func _process(delta: float) -> void:
	print(position)

func interact() -> void:
	get_tree().call_group("TV", "tv_noise", false)
	queue_free()
