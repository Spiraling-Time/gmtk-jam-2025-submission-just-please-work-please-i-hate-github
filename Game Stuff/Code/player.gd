extends CharacterBody2D

@onready var world = $".."


@onready var ani = $animationplayer
@onready var sprite = $Sprite2D
@onready var touching_ground = $"Touching ground"

@onready var wide_collision = $CollisionShape2D
@onready var wide_stand_collision = $"Touching ground/CollisionShape2D"
@onready var skinny_collision = $Idle_collision_shape
@onready var skinny_stand_collision = $"Touching ground/Idle_collision_shape"

@onready var audio = $AudioStreamPlayer2D

@onready var jump = $jump


var speed = 500
var gravity = 10
var dir
var jump_height = 340

var far_enough: bool = false

func _ready() -> void:
	ani.play("Idle")
	turn_on_wide_collision()

func _physics_process(delta: float) -> void:
		
	if Input.is_action_pressed("left"):
		sprite.flip_h = false
		if touching_ground.get_overlapping_bodies().size() != 0: ani.play("Run")
		dir = -1
		turn_on_wide_collision()
	elif Input.is_action_pressed("right"):
		sprite.flip_h = true
		if touching_ground.get_overlapping_bodies().size() != 0: ani.play("Run")
		dir = 1
		turn_on_wide_collision()
	else:
		if touching_ground.get_overlapping_bodies().size() != 0: ani.play("Idle")
		dir = 0
		turn_on_skinny_collision()
		
	if touching_ground.get_overlapping_bodies().size() != 0: velocity.y = 0
	else:
		velocity.y += gravity

		
		
	if touching_ground.get_overlapping_bodies().size() == 0: ani.play("Fall")
	elif Input.is_action_pressed("up"):
		jump.play()
		ani.play("Jump")
		velocity.y = -1*jump_height
		turn_on_wide_collision()
	
	velocity.x = dir*speed
	move_and_slide()
	
	if global_position.y >= 200.0 and !audio.playing:
		audio.play()
	
	
	
	if global_position.y >= 450.0 and ! far_enough:
		world.score += 1
		world.save_score()
		far_enough = true

func turn_on_wide_collision():
	if !skinny_collision.disabled: skinny_collision.disabled = true
	if !skinny_stand_collision.disabled:	skinny_stand_collision.disabled = true
	if wide_collision.disabled: wide_collision.disabled = false
	if wide_stand_collision.disabled: wide_stand_collision.disabled = false

func turn_on_skinny_collision():
	if skinny_collision.disabled: skinny_collision.disabled = false
	if skinny_stand_collision.disabled:	skinny_stand_collision.disabled = false
	if !wide_collision.disabled: wide_collision.disabled = true
	if !wide_stand_collision.disabled: wide_stand_collision.disabled = true


func _on_audio_stream_player_2d_finished() -> void:

	get_tree().reload_current_scene()
