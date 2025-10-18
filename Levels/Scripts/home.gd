extends Node3D

@onready var creature: Creature = $Creature

func set_end() -> void:
	creature.show()
