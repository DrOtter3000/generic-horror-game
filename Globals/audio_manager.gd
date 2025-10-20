extends Node

@onready var car_start_audio_player: AudioStreamPlayer = $CarStartAudioPlayer
@onready var pop_player: AudioStreamPlayer = $PopPlayer
@onready var horror_ambient_player: AudioStreamPlayer = $HorrorAmbientPlayer

func play_test_sound() -> void:
	pop_player.play()
