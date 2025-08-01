extends Node2D

var save_path_first_time = "user://variable.first_time"
var first_time: bool = true

@onready var sprite = $Sprite2D

@onready var main_buttons = $Buttons

@onready var exit_button = $Exit

@onready var audio = $AudioStreamPlayer2D

var save_path_locked = "user://variable.locked"
var locked: bool = true

var game_mode = "normal"

func _ready() -> void:
	load_data_locked()
	#save_first_time()
	load_data_first_time()
	if first_time:
		sprite.frame = 4
		main_buttons.visible = false
		exit_button.visible = true
	else:
		if locked: sprite.frame = 0
		else: sprite.frame = 1
	audio.play()

func save_first_time():
	var file = FileAccess.open(save_path_first_time, FileAccess.WRITE)
	file.store_var(first_time)


func load_data_first_time():
	if FileAccess.file_exists(save_path_first_time):
		var file = FileAccess.open(save_path_first_time, FileAccess.READ)
		first_time = file.get_var()


func save_locked():
	var file = FileAccess.open(save_path_locked, FileAccess.WRITE)
	file.store_var(locked)


func load_data_locked():
	if FileAccess.file_exists(save_path_locked):
		var file = FileAccess.open(save_path_locked, FileAccess.READ)
		locked = file.get_var()


func _on_controls_pressed() -> void:
	sprite.frame = 2.0
	main_buttons.visible = false
	exit_button.visible = true


func _on_begin_pressed() -> void:
	if game_mode == "normal": get_tree().change_scene_to_file("res://Game Stuff/Scenes/world.tscn")


func _on_level_select_pressed() -> void:
	if !locked: sprite.frame = 5
	main_buttons.visible = false
	exit_button.visible = true

func _on_credits_pressed() -> void:
	sprite.frame = 3
	main_buttons.visible = false
	exit_button.visible = true


func _on_exit_pressed() -> void:
	main_buttons.visible = true
	exit_button.visible = false
	if locked: sprite.frame = 0
	else: sprite.frame = 1
	if first_time:
		first_time = false
		save_first_time()

func _on_audio_stream_player_2d_finished() -> void:
	audio.play()
