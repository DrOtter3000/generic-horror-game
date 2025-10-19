extends MeshInstance3D

@onready var material_off: Material = preload("res://Materials/tv_off.tres")
@onready var material_on: Material = preload("res://Materials/static_noise_shader.tres")
@onready var static_audio_player: AudioStreamPlayer3D = $StaticAudioPlayer


func tv_noise(status: bool, material_pos: int) -> void:
	if status == false:
		set_surface_override_material(2, material_off)
		static_audio_player.stop()
	else:
		set_surface_override_material(material_pos, material_on)
		static_audio_player.play()
