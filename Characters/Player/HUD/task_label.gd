extends Label

var task_id: String


func destroy(id) -> void:
	print("hi")
	if id == text:
		queue_free()
