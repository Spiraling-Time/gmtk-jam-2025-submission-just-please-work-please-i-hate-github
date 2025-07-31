extends Node2D

@onready var world = $".."


func _on_death_scream_finished() -> void:
	world.screams += 1
	world.save_screams()
	world.reset()
	
