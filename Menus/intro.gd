extends Control

var progress := 0.0
@onready var progress_bar: ProgressBar = $MarginContainer2/VBoxContainer/ProgressBar

func _process(delta: float) -> void:
	if progress == 0.0:
		progress_bar.hide()
	else:
		progress_bar.show()
	
	if progress >= 100:
		start_game()

	
	if Input.is_action_pressed("jump"):
		progress += 30.0 * delta
	else:
		progress = 0.0
	
	progress_bar.value = progress

func start_game() -> void:
	get_tree().change_scene_to_file("res://Levels/laundry.tscn")

func _on_timer_timeout() -> void:
	start_game()
