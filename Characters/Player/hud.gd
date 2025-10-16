extends CanvasLayer

@onready var interaction_label: Label = $InteractionLabel
@onready var communication_container: MarginContainer = $CommunicationContainer
@onready var name_label: Label = $CommunicationContainer/MarginContainer/VBoxContainer/NameLabel
@onready var message_label: Label = $CommunicationContainer/MarginContainer/VBoxContainer/MessageLabel

func deactivate_interaction_label(status: bool) -> void:
	if status:
		interaction_label.hide()
		communication_container.show()
	else:
		interaction_label.show()
		communication_container.hide()

func update_communication_container(person: String, message: String) -> void:
	name_label.text = person
	message_label.text = message
