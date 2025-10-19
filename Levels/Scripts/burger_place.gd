extends Node3D

@onready var drive_through_scene = preload("res://Levels/drive_through_window.tscn")
@onready var creature = preload("res://Characters/Creature/creature.tscn")
@onready var lost_purse = preload("res://Levels/lost_purse.tscn")
@onready var lost_purse_position: Node3D = $LostPursePosition
@onready var drive_through_position: Node3D = $DriveThroughPosition
@onready var creature_position: Node3D = $CreaturePosition

func add_lost_purse() -> void:
	var lost_purse_instance = lost_purse.instantiate()
	add_child(lost_purse_instance)
	lost_purse_instance.position = lost_purse_position.position

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

func turn_off_tv() -> void:
	await get_tree().create_timer(10.0).timeout
	get_tree().call_group("TV", "tv_noise", false, 2)
