extends task_interactor

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var tv_switch_position: Node3D = $"../TVSwitchPosition"
@onready var tv_switch = preload("res://Levels/tv_switch.tscn")
@onready var creature_position: Node3D = $"../CreaturePosition"


func interact() -> void:
	super()
	var tv_switch_instance = tv_switch.instantiate()
	get_parent().add_child(tv_switch_instance)
	tv_switch_instance.rotation = tv_switch_position.rotation
	tv_switch_instance.position = tv_switch_position.position
	creature_position.show()
	animation_player.play("repair")

func turn_tv_on() -> void:
	get_tree().call_group("TV", "tv_noise", true, 2)
