extends Control

var master_index: int
var is_in_main_menu := false

@onready var sound_slider: HSlider = $CenterContainer/VBoxContainer/VBoxContainer/SoundSlider
@onready var back_to_menu_button: Button = $CenterContainer/VBoxContainer/BackToMenuButton
@onready var sensetivity_slider: HSlider = $CenterContainer/VBoxContainer/VBoxContainer2/SensetivitySlider


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true
	master_index = AudioServer.get_bus_index("Master")
	sound_slider.value = _get_volume(master_index)
	if !is_in_main_menu:
		back_to_menu_button.show()
	else:
		back_to_menu_button.hide()
	sensetivity_slider.value = Gamestate.mouse_sensetivity


func  _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		_on_back_button_pressed()

func _get_volume(bus_index: int) -> float:
	var db_volume = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(db_volume)

func _set_volume(bus_index: int, volume: float) -> void:
	var db_volume = linear_to_db(volume)
	AudioServer.set_bus_volume_db(bus_index, db_volume)

func _on_master_volume_slider_value_changed(value: float) -> void:
	_set_volume(master_index, value)

func _on_back_button_pressed() -> void:
	if !is_in_main_menu:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	queue_free()

func _on_back_to_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menus/main_menu.tscn")

func _on_sensetivity_slider_value_changed(value: float) -> void:
	Gamestate.mouse_sensetivity = value

func _on_sound_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		AudioManager.play_test_sound()

func _on_fullscreen_button_pressed() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
