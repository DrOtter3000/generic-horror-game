extends task_interactor

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func interact() -> void:
	super()
	animation_player.play("repair")
