extends task_interactor

func interact() -> void:
	super()
	player.change_working_status(true)
	get_tree().call_group("HUD", "deactivate_interaction_label", true)
	get_tree().call_group("HUD", "update_communication_container", "You:", "Yes, Hello?")
	await get_tree().create_timer(3).timeout
	get_tree().call_group("HUD", "deactivate_interaction_label", false)
	player.change_working_status(false)
