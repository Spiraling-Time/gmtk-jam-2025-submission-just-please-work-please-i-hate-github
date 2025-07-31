extends Node2D

@onready var world = $".."
@onready var dragons1 = $Dragons1
@onready var dragons2 = $Dragons2

func _on_death_scream_finished() -> void:
	world.screams += 1
	world.save_screams()
	world.reset()
	

func _ready() -> void:
	if world.score > 70 and world.score < 100:
		if randi_range(0,1) == 1:
			dragons1.visible = true
			dragons2.visible = false
		else:
			dragons1.visible = false
			dragons2.visible = true
	else:
		dragons1.visible = false
		dragons2.visible = false
