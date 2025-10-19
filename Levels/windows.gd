extends MeshInstance3D

@onready var window_player: AnimationPlayer = $WindowPlayer

func open_window(status: bool) -> void:
	if status == true:
		window_player.play("open")
	else:
		window_player.play("close")
		
