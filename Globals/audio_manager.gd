extends Node

@onready var car_start_audio_player: AudioStreamPlayer = $CarStartAudioPlayer
@onready var pop_player: AudioStreamPlayer = $PopPlayer

func play_test_sound() -> void:
	pop_player.play()
