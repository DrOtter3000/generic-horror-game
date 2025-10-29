extends task_interactor

@onready var timer: Timer = $Timer

var wait_time := 2.0
var creature: Creature
var ready_to_continue_dialogue := false
var dialogue_to_play := 0

var dialogue_array := [
	["You:", "W-w-what the hell is going on?"],
	["Creature:", "Sorry for my weird look. Some people say, I would scare them."],
	["You:", "OK, here is your purse."],
	["Creature:", "Thank you. Oh, one more question. What is your perfume? It smells... tasty."],
	["You:", "I don't use perfume."],
	["Creature:", "Oh... then I have to leave. Fast... you smell tasty. See you."],
	["You:", "See you!"]
]

func _ready() -> void:
	super()
	timer.wait_time = wait_time
	creature = get_tree().get_first_node_in_group("Creature")
	

func interact() -> void:
	super()
	player.change_working_status(true)
	get_tree().call_group("Window", "open_window", true)
	get_tree().call_group("HUD", "deactivate_interaction_label", true)
	get_tree().call_group("HUD", "update_communication_container", "Creature:", "Hi, I'm here to pick up my purse.")
	await get_tree().create_timer(wait_time).timeout
	ready_to_continue_dialogue = true

func _process(delta: float) -> void:
	if ready_to_continue_dialogue:
		if Input.is_action_just_pressed("jump"):
			ready_to_continue_dialogue = false
			get_tree().call_group("HUD", "update_communication_container", dialogue_array[dialogue_to_play][0], dialogue_array[dialogue_to_play][1])
			dialogue_to_play += 1
			if dialogue_to_play == dialogue_array.size():
				quit_dialogue()
			else:
				timer.start()

func quit_dialogue() -> void:
	creature.leave_window()
	get_tree().call_group("Window", "open_window", false)
	get_tree().call_group("HUD", "deactivate_interaction_label", false)
	get_tree().call_group("BurgerPlace", "turn_off_tv")
	player.change_working_status(false)
	queue_free()

func _on_timer_timeout() -> void:
	ready_to_continue_dialogue = true
