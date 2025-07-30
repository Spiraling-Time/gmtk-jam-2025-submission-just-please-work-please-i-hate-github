extends CharacterBody2D

@onready var ani = $animationplayer
@onready var sprite = $Sprite2D
@onready var touching_ground = $"Touching ground"

var speed = 100
var gravity = 10
var dir


func _ready() -> void:
	ani.play("Idle")

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		sprite.flip_h = false
		if touching_ground.get_overlapping_bodies().size() != 0: ani.play("Run")
		dir = -1
	elif Input.is_action_pressed("right"):
		sprite.flip_h = true
		if touching_ground.get_overlapping_bodies().size() != 0: ani.play("Run")
		dir = 1
	else:
		if touching_ground.get_overlapping_bodies().size() != 0: ani.play("Idle")
		dir = 0
	if touching_ground.get_overlapping_bodies().size() != 0: gravity = 0
	else: gravity += 10
	velocity = Vector2(dir*speed, gravity)
	move_and_slide()
