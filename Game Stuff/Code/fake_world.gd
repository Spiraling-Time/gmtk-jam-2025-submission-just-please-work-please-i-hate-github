extends Node2D

@onready var world = $".."
@onready var dragons1 = $Dragons1
@onready var dragons2 = $Dragons2


var side

func _on_death_scream_finished() -> void:
	world.screams += 1
	world.save_screams()
	world.reset()
	

func _ready() -> void:
	if world.score > 71 and world.score < 100:
		dragons1.scale = Vector2(1,1)
		dragons2.scale = Vector2(-1,1)
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

func _physics_process(delta: float) -> void:
	if world.score > 71 and world.score < 100:
		if side == "left":
			dragons1.position.y -= 7
			if dragons1.position.y <= -100: dragons1.scale = Vector2(2,2)

		elif side == "right":
			dragons2.position.y -= 7
			if dragons2.position.y <= -100: dragons2.scale = Vector2(-2,2)
			
		

func hide_dragons():
	dragons1.visible = false
	dragons2.visible = false
