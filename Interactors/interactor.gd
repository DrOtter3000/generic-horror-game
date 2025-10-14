class_name Interactor
extends Area3D

@export var text := "Interact"
@export var task_label: PackedScene

var player: CharacterBody3D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
