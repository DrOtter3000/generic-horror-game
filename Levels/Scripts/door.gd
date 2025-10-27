extends Interactor

@export var is_closed := true
@export var is_metal := false

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var door_sound_player: AudioStreamPlayer3D = $DoorSoundPlayer

var wood_open = preload("res://Audio/SFX/Doors/door_wood_open.wav")
var wood_close = preload("res://Audio/SFX/Doors/door_wood_close.wav")
var metal_open = preload("res://Audio/SFX/Doors/door_metal_open.wav")
var metal_close = preload("res://Audio/SFX/Doors/door_metal_close.wav")


func _ready() -> void:
	text = "Use Door"
	door_sound_player.pitch_scale = randf_range(0.9, 1.2)

func interact() -> void:
	if !animation_player.is_playing():
		if is_closed:
			if is_metal:
				door_sound_player.stream = metal_open
			else:
				door_sound_player.stream = wood_open
			animation_player.play("open")
		else:
			if is_metal:
				door_sound_player.stream = metal_close
			else:
				door_sound_player.stream = wood_close
			animation_player.play("close")
		is_closed = !is_closed
		await get_tree().create_timer(0.2).timeout
		door_sound_player.play()
