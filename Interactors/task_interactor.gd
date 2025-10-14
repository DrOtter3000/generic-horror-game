class_name task_interactor
extends Interactor

@export var task_name := "Add Job Description"

func _ready() -> void:
	super()
	add_label()

func interact() -> void:
	remove_label()

func add_label() -> void:
	var task = task_label.instantiate()
	player.tasks.add_child(task)
	task.text = task_name

func remove_label() -> void: 
	get_tree().call_group("Task", "destroy", task_name)
