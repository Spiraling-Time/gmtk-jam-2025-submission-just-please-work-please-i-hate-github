extends Node2D

var save_path_score = "user://variable.score"

var saved_score = 0

var score = 0

@onready var audio = $AudioStreamPlayer2D
@onready var so_called_score = $CanvasLayer/Label


func _ready() -> void:
	audio.play()
	#save_score()
	load_data_score()
	score = saved_score

func _on_audio_stream_player_2d_finished() -> void:
	audio.play()

func save_score():
	var file = FileAccess.open(save_path_score, FileAccess.WRITE)
	file.store_var(score)


func load_data_score():
	if FileAccess.file_exists(save_path_score):
		var file = FileAccess.open(save_path_score, FileAccess.READ)
		saved_score = file.get_var()

func _physics_process(delta: float) -> void:
	so_called_score.text = "%d" % score
