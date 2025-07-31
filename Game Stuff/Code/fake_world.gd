extends Node2D


func _on_death_scream_finished() -> void:
	$"..".reset()
	queue_free()
	
