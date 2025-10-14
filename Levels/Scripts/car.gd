extends Interactor

func _ready() -> void:
	super()
	text = "Use Car"

func interact() -> void:
	var job_counter = player.tasks.get_child_count()
	if job_counter == 0:
		text = "Use Car"
		queue_free()
	else:
		#TODO: Add other behaviour
		print("do your stuffs")
