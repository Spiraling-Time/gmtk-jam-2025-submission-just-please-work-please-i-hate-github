extends Node2D

var save_path_score = "user://variable.score"


var score = 0

@onready var audio = $"Background music"
@onready var so_called_score = $CanvasLayer/Scorer
@onready var Narrator = $CanvasLayer/Narrator
@onready var Icon1 = $CanvasLayer/Icon1


var fake_world = preload("res://Game Stuff/Scenes/fake_world.tscn")

func _ready() -> void:
	audio.play()
	#save_score()
	load_data_score()
	reset()
	



func save_score():
	var file = FileAccess.open(save_path_score, FileAccess.WRITE)
	file.store_var(score)


func load_data_score():
	if FileAccess.file_exists(save_path_score):
		var file = FileAccess.open(save_path_score, FileAccess.READ)
		score = file.get_var()

func _physics_process(delta: float) -> void:
	so_called_score.text = "%d" % score

func reset():
	await get_tree().process_frame
	add_child(fake_world.instantiate())
	


func _on_background_music_finished() -> void:
	audio.play()
