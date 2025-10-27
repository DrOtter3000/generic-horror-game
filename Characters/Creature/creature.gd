class_name Creature
extends Node3D

@export var breathing := true
@export var breath_sound_array: Array[AudioStream]

@onready var breath_player: AudioStreamPlayer3D = $BreathPlayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var moving := false
var speed := 1.5

@onready var animations: AnimationPlayer = $AnimationPlayer

func leave_window() -> void:
	rotation.y = lerp(rotation.y, -80.0, -0.1)
	animation_player.play("walk")
	moving = true

func _process(delta: float) -> void:
	if moving:
		position.z -= speed * delta

func play_breath_sound() -> void:
	breath_player.stream = breath_sound_array.pick_random()
	breath_player.pitch_scale = randf_range(0.9, 1.1)
	breath_player.play()

func _on_timer_timeout() -> void:
	if breathing:
		play_breath_sound()
