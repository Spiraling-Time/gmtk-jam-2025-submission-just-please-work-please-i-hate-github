extends Node2D

@onready var world = $".."
@onready var dragons1 = $Dragons1
@onready var dragons2 = $Dragons2

@onready var player = $Player

var side

func _on_death_scream_finished() -> void:
	if world.score > 71 and world.score < 100:
		if side == "left":
			if player.global_position.x < 0: world.dragons_slayed += 1
		elif side == "right":
			if player.global_position.x > 0: world.dragons_slayed += 1
	world.screams += 1
	world.save_screams()
	world.reset()
	

func _ready() -> void:
	if world.score > 71 and world.score < 100:
		if randi_range(0,1) == 1:
			side = "left"
			dragons1.visible = true
			dragons2.visible = false
		else:
			side = "right"
			dragons1.visible = false
			dragons2.visible = true
	else:
		side = null
		dragons1.visible = false
		dragons2.visible = false
