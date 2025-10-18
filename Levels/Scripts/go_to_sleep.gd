extends task_interactor

@onready var creature: Creature = $"../Creature"
@onready var danger_zone: DangerZone = $"../Creature/DangerZone"


func interact() -> void:
	super()
	player.working = true
	player.fade_out()
	creature.show()
	await get_tree().create_timer(2).timeout
	player.fade_in()
	danger_zone.active = true
	player.working = false
	queue_free()
