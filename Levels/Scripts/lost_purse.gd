extends task_interactor

@onready var phone_sound: AudioStreamPlayer3D = $PhoneSound
@onready var pick_up_phone_sound = preload("res://Audio/SFX/PickUpPhone.wav")
@onready var hang_up_phone_sound = preload("res://Audio/SFX/HangUpPhone.wav")
@onready var timer: Timer = $Timer

var wait_time := 2.0
var ready_to_continue_dialogue := false
var dialogue_to_play := 0
var dialogue_array := [
	["???:", "Hey, am I right at BurgerPiz?"],
	["You:", "Yes, but this place is closed, I'm the janitor."],
	["???:", "Oh, I don't want to order anything. I lost my purse, it is red. Can you have a look if one has found it?"],
	["You:", "Yes, it is here, I can see it. You can pick it up tomorrow."],
	["???:", "Can I pick it up right now? I'm next to the drive trough in a few seconds."],
	["You:", "OK, why not. But please hurry up."],
	["???:", "Thank you alot. Come to the window, I'm there right now!"],
	["", ""]
]

func _ready() -> void:
	super()
	timer.wait_time = wait_time

func interact() -> void:
	super()
	phone_sound.stop()
	text = ""
	phone_sound.stream = pick_up_phone_sound
	phone_sound.play()
	player.change_working_status(true)
	get_tree().call_group("HUD", "deactivate_interaction_label", true)
	get_tree().call_group("HUD", "update_communication_container", "You", "Yes, hello.")
	await get_tree().create_timer(wait_time).timeout
	ready_to_continue_dialogue = true

func _process(delta: float) -> void:
	if ready_to_continue_dialogue:
		if Input.is_action_just_pressed("jump"):
			ready_to_continue_dialogue = false
			get_tree().call_group("HUD", "update_communication_container", dialogue_array[dialogue_to_play][0], dialogue_array[dialogue_to_play][1])
			dialogue_to_play += 1
			if dialogue_to_play == 6:
				get_tree().call_group("Purse", "queue_free")
			if dialogue_to_play == dialogue_array.size():
				quit_dialogue()
			else:
				timer.start()

func quit_dialogue() -> void:
	get_tree().call_group("BurgerPlace", "add_drive_trough_task")
	get_tree().call_group("HUD", "deactivate_interaction_label", false)
	phone_sound.stream = hang_up_phone_sound
	phone_sound.play()
	await get_tree().create_timer(1).timeout
	player.change_working_status(false)
	queue_free()

func _on_timer_timeout() -> void:
	ready_to_continue_dialogue = true
