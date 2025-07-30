extends Node2D

@onready var audio = $AudioStreamPlayer2D

func _ready() -> void:
	audio.play()


func _on_audio_stream_player_2d_finished() -> void:
	audio.play()
