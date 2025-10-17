extends Node3D

@onready var drive_through_scene = preload("res://Levels/drive_through_window.tscn")
@onready var creature = preload("res://Characters/Creature/creature.tscn")
@onready var drive_through_position: Node3D = $DriveThroughPosition
@onready var creature_position: Node3D = $CreaturePosition


func add_drive_trough_task() -> void:
	spawn_creature()
	var drive_through = drive_through_scene.instantiate()
	add_child(drive_through)
	drive_through.position = drive_through_position.position

func spawn_creature() -> void:
	var creature_instance = creature.instantiate() as Creature
	add_child(creature_instance)
	creature_instance.position = creature_position.position
	creature_instance.rotation = creature_position.rotation
	creature_instance.scale = Vector3(0.3, 0.3, 0.3)
