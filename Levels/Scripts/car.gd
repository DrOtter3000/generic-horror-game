extends Interactor

var jobs_done := false

func interact() -> void:
	if jobs_done:
		queue_free()
	else:
		print("do your stuffs")

func everything_finished() -> void:
	text = "Use Car"
