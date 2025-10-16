extends Node3D

@onready var drive_through_position: Node3D = $DriveThroughPosition
@onready var drive_through_scene = preload("res://Levels/drive_through_window.tscn")

func add_drive_trough_task():
	var drive_through = drive_through_scene.instantiate()
	add_child(drive_through)
	drive_through.position = drive_through_position.position
