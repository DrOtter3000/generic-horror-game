extends Interactor

@export var is_closed := true

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func interact() -> void:
	if !animation_player.is_playing():
		if is_closed:
			animation_player.play("open")
		else:
			animation_player.play("close")
		is_closed = !is_closed
