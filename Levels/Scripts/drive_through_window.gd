extends task_interactor

var wait_time := .1
var creature: Creature

func _ready() -> void:
	super()
	creature = get_tree().get_first_node_in_group("Creature")

func interact() -> void:
	super()
	player.change_working_status(true)
	get_tree().call_group("HUD", "deactivate_interaction_label", true)
	get_tree().call_group("HUD", "update_communication_container", "Creature", "Hi, I'm here to pick up my purse")
	await get_tree().create_timer(wait_time).timeout
	get_tree().call_group("HUD", "update_communication_container", "You:", "W-w-what the hell is going on?")
	await get_tree().create_timer(wait_time).timeout
	get_tree().call_group("HUD", "update_communication_container", "Creature", "Sorry for my weird look. Some people say, I would scare them")
	await get_tree().create_timer(wait_time).timeout
	get_tree().call_group("HUD", "update_communication_container", "You:", "OK, here is your purse")
	await get_tree().create_timer(wait_time).timeout
	get_tree().call_group("HUD", "update_communication_container", "Creature", "Thank you. Oh, one more question. What is your perfume? It smells... tasty")
	await get_tree().create_timer(wait_time).timeout
	get_tree().call_group("HUD", "update_communication_container", "You:", "I don't use perfume")
	await get_tree().create_timer(wait_time).timeout
	get_tree().call_group("HUD", "update_communication_container", "Creature:", "Oh... then I have to leave. Fast... you smell tasty. See you")
	await get_tree().create_timer(wait_time).timeout
	get_tree().call_group("HUD", "update_communication_container", "You:", "See you")
	await get_tree().create_timer(wait_time).timeout
	creature.leave_window()
	get_tree().call_group("HUD", "deactivate_interaction_label", false)
	player.change_working_status(false)
