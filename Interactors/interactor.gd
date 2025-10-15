class_name Interactor
extends Area3D

@export var text := "Interact"
#@export var task_label: PackedScene
@onready var task_label = preload("res://Characters/Player/HUD/task_label.tscn")

var player: Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
