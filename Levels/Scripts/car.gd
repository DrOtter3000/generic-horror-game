extends Interactor

@export var next_scene: PackedScene

func _ready() -> void:
	super()
	text = "Use Car"

func interact() -> void:
	var job_counter = player.tasks.get_child_count()
	if job_counter == 0:
		switch_scene()
	else:
		#TODO: Add other behaviour
		print("do your stuffs")

func switch_scene() -> void:
	AudioManager.car_start_audio_player.play()
	get_tree().change_scene_to_packed(next_scene)
