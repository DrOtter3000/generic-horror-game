extends task_interactor

# TODO: add purse

@onready var phone_sound: AudioStreamPlayer3D = $PhoneSound
@onready var pick_up_phone_sound = preload("res://Audio/SFX/PickUpPhone.wav")
@onready var hang_up_phone_sound = preload("res://Audio/SFX/HangUpPhone.wav")

var wait_time := .1

func interact() -> void:
	super()
	player.change_working_status(true)
	text = ""
	phone_sound.stop()
	phone_sound.stream = pick_up_phone_sound
	phone_sound.play()
	get_tree().call_group("HUD", "deactivate_interaction_label", true)
	get_tree().call_group("HUD", "update_communication_container", "You:", "Yes, Hello?")
	await get_tree().create_timer(wait_time).timeout
	get_tree().call_group("HUD", "update_communication_container", "???:", "Hey, am I right at BurgerPlace?")
	await get_tree().create_timer(wait_time).timeout
	get_tree().call_group("HUD", "update_communication_container", "You:", "Yes, but this place is closed, I'm just the janitor.")
	await get_tree().create_timer(wait_time).timeout
	get_tree().call_group("HUD", "update_communication_container", "???:", "Oh, I don't want to order anything. I lost my purse, it is red. Can you have a look if one has found it?")
	await get_tree().create_timer(wait_time).timeout
	get_tree().call_group("HUD", "update_communication_container", "You:", "Yes, it is here, I can see it. You can pick it up tomorrow.")
	await get_tree().create_timer(wait_time).timeout
	get_tree().call_group("HUD", "update_communication_container", "???:", "Can I pick it up right now? I'm next to the drive trough in a few seconds.")
	await get_tree().create_timer(wait_time).timeout
	get_tree().call_group("HUD", "update_communication_container", "You:", "OK, why not. But please hurry up.")
	await get_tree().create_timer(wait_time).timeout
	get_tree().call_group("HUD", "update_communication_container", "???:", "Thank you alot. Come to the window, I'm there right now!")
	await get_tree().create_timer(wait_time).timeout
	get_tree().call_group("BurgerPlace", "add_drive_trough_task")
	get_tree().call_group("HUD", "deactivate_interaction_label", false)
	phone_sound.stream = hang_up_phone_sound
	phone_sound.play()
	await get_tree().create_timer(1).timeout
	player.change_working_status(false)
	queue_free()
