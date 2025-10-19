class_name Player
extends CharacterBody3D

const SPEED = 4.0
const JUMP_VELOCITY = 4.5

@export var normal_camera_position := 1.8

var working := false

@onready var camera_3d: Camera3D = $Camera3D
@onready var interaction_raycast: RayCast3D = $Camera3D/InteractionRaycast
@onready var interaction_label: Label = $HUD/InteractionLabel
@onready var tasks: VBoxContainer = $HUD/Taskscontainer/Tasks
@onready var finish_yourjob_label: Label = $HUD/FinishYourjobLabel
@onready var finish_job_timer: Timer = $HUD/FinishJobTimer
@onready var flashlight: SpotLight3D = $Camera3D/Flashlight
@onready var fade_player: AnimationPlayer = $FadePlayer
@onready var hud: CanvasLayer = $HUD
@onready var options = preload("res://Menus/options.tscn")

### Steps ###
@export var step_after_dist := 2.5
var dist_travelled_since_last_step := 0.0
@onready var step_player: AudioStreamPlayer3D = $StepPlayer
@onready var last_pos: Vector3 = global_position
var footstep_sounds := [
	preload("res://Audio/SFX/Footsteps/footsteps-sound-effect_1.wav"),
	preload("res://Audio/SFX/Footsteps/footsteps-sound-effect_2.wav"),
	preload("res://Audio/SFX/Footsteps/footsteps-sound-effect_3.wav"),
	preload("res://Audio/SFX/Footsteps/footsteps-sound-effect_4.wav"),
	preload("res://Audio/SFX/Footsteps/footsteps-sound-effect_5.wav")
]

func _ready() -> void:
	working = true
	hud_visible(false)
	flashlight.light_energy = 0
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	fade_in()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		var options_instance = options.instantiate()
		add_child(options_instance)

func _physics_process(delta: float) -> void:
	if working:
		return
	
	if Input.is_action_just_pressed("flashlight"):
		if flashlight.light_energy == 0.0:
			flashlight.light_energy = 1.0
		else:
			flashlight.light_energy = 0.0
	
	### Steps ###
	if !is_on_floor():
		dist_travelled_since_last_step = 0.0
	
	dist_travelled_since_last_step += global_position.distance_to(last_pos)
	if dist_travelled_since_last_step >= step_after_dist:
		var footstep_sound = footstep_sounds.pick_random() 
		dist_travelled_since_last_step = 0.0
		step_player.stream = footstep_sound
		step_player.pitch_scale = randf_range(0.8, 1.2)
		step_player.play()
	
	last_pos = global_position
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_pressed("crouch"):
		camera_3d.position.y = lerp(camera_3d.position.y, normal_camera_position / 2, 0.1)
	else:
		camera_3d.position.y = lerp(camera_3d.position.y, normal_camera_position, 0.1)
	
	## Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
	check_for_interactor()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if working:
			return
		rotation_degrees.y -= event.relative.x * Gamestate.mouse_sensetivity
		camera_3d.rotation_degrees.x -= event.relative.y * Gamestate.mouse_sensetivity
		camera_3d.rotation_degrees.x = clamp(camera_3d.rotation_degrees.x, -90, 90)


func check_for_interactor():
	#TODO: make this run
	if interaction_raycast.is_colliding():
		var collider = interaction_raycast.get_collider()
		if collider is Interactor:
			interaction_label.text = collider.text + " (E)"
			if Input.is_action_just_pressed("interact"):
				collider.interact()
		else:
			if collider is DangerZone:
				if collider.active:
					# TODO: connect jumpscare 
					get_tree().change_scene_to_file("res://Jumpscare/jumpscare.tscn")
			interaction_label.text = "."
	else:
		interaction_label.text = "."

func change_working_status(status: bool) -> void:
	working = status

func fade_in() -> void:
	fade_player.play("fade_in")

func fade_out() -> void:
	fade_player.play("fade_out")

func show_finish_your_job_label() -> void:
	finish_yourjob_label.show()
	finish_job_timer.stop()
	finish_job_timer.start()

func _on_finish_job_timer_timeout() -> void:
	finish_yourjob_label.hide()

func hud_visible(status: bool) -> void:
	if status == true:
		hud.show()
	else:
		hud.hide()
