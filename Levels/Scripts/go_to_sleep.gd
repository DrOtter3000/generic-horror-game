extends task_interactor

@onready var creature: Creature = $"../Creature"
@onready var danger_zone: DangerZone = $"../Creature/DangerZone"
@onready var tv_switch = preload("res://Levels/tv_switch.tscn")
@onready var tv_switch_position: Node3D = $"../TVSwitchPosition"
@onready var snore_sound_player: AudioStreamPlayer = $"../SnoreSoundPlayer"

func interact() -> void:
	super()
	player.working = true
	player.fade_out()
	await get_tree().create_timer(2).timeout
	snore_sound_player.play()
	await snore_sound_player.finished
	creature.show()
	player.fade_in()
	danger_zone.active = true
	player.working = false
	get_tree().call_group("TV", "tv_noise", true, 1)
	var tv_switch_instance = tv_switch.instantiate()
	get_parent().add_child(tv_switch_instance)
	tv_switch_instance.rotation = tv_switch_position.rotation
	tv_switch_instance.position = tv_switch_position.position
	tv_switch_instance.last_level = true
	queue_free()
