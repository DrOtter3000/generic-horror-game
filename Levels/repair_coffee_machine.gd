extends task_interactor

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func interact() -> void:
	animation_player.play("repair")

func turn_tv_on() -> void:
	get_tree().call_group("TV", "tv_noise", true)
