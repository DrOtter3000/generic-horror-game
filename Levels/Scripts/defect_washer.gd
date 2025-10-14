extends task_interactor

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	super()

func interact() -> void:
	super()
	#TODO: Add animation
	animation_player.play("repair")
