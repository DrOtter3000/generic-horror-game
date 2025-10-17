class_name Creature
extends Node3D

var moving := false
var speed := 1.5

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func leave_window() -> void:
	rotation.y = lerp(rotation.y, -80.0, -0.1)
	animation_player.play("walk")
	moving = true

func _process(delta: float) -> void:
	if moving:
		position.z -= speed * delta
		
