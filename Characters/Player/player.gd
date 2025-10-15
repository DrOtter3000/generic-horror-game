extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var mouse_sensetivity := .08
@export var normal_camera_position := 1.8

var working := false

@onready var camera_3d: Camera3D = $Camera3D
@onready var interaction_raycast: RayCast3D = $Camera3D/InteractionRaycast
@onready var interaction_label: Label = $HUD/InteractionLabel
@onready var tasks: VBoxContainer = $HUD/Taskscontainer/Tasks
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	fade_in()

func _physics_process(delta: float) -> void:
	if working:
		return
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_pressed("crouch"):
		camera_3d.position.y = lerp(camera_3d.position.y, normal_camera_position / 2, 0.1)
	else:
		camera_3d.position.y = lerp(camera_3d.position.y, normal_camera_position, 0.1)
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
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
		rotation_degrees.y -= event.relative.x * mouse_sensetivity
		camera_3d.rotation_degrees.x -= event.relative.y * mouse_sensetivity
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
			interaction_label.text = "."
	else:
		interaction_label.text = "."

func change_working_status(status: bool) -> void:
	working = status

func fade_in() -> void:
	animation_player.play("fade_in")

func fade_out() -> void:
	animation_player.play("fade_out")
