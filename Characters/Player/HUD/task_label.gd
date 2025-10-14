extends Label

var task_id: String


func destroy(id) -> void:
	if id == text:
		queue_free()
