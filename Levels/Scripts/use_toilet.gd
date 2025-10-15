extends Interactor

@onready var toilet_sound: AudioStreamPlayer3D = $ToiletSound
@onready var cereal_bowl: MeshInstance3D = $Cereal_bowl_001

func interact() -> void:
	player.change_working_status(true)
	get_tree().create_timer(1).timeout
	cereal_bowl.hide()
	toilet_sound.play()


func _on_toilet_sound_finished() -> void:
	player.change_working_status(false)
