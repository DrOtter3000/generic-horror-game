extends Interactor

@export var has_cereals := true

@onready var toilet_sound: AudioStreamPlayer3D = $ToiletSound
@onready var cereal_bowl: MeshInstance3D = $Cereal_bowl_001

var standard_text: String

func _ready() -> void:
	super()
	standard_text = text
	if has_cereals:
		text = "Flush Cereals"


func interact() -> void:
	player.change_working_status(true)
	if has_cereals:
		cereal_bowl.hide()
		has_cereals = false
		text = standard_text
	toilet_sound.play()

func _on_toilet_sound_finished() -> void:
	player.change_working_status(false)
