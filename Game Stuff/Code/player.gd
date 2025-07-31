extends CharacterBody2D

@onready var world = $"../.."
@onready var fake_world = $".."

@onready var ani = $animationplayer
@onready var sprite = $Sprite2D
@onready var touching_ground = $"Touching ground"

@onready var wide_collision = $CollisionShape2D
@onready var wide_stand_collision = $"Touching ground/CollisionShape2D"
@onready var skinny_collision = $Idle_collision_shape
@onready var skinny_stand_collision = $"Touching ground/Idle_collision_shape"

@onready var audio = $death_scream

@onready var jump = $jump


var speed = 500
var gravity = 10
var dir
var jump_height = 340

var far_enough: bool = false

var scream_type = "death"

@onready var dragons1 = $"../Dragons1"
@onready var dragons2 = $"../Dragons2"

@onready var sword = $Sword

@onready var pop = $popper


func _ready() -> void:
	ani.play("Idle")
	turn_on_wide_collision()
	if world.score > 50 and world.score < 56:
		if scream_type != "yay":
			scream_type = "yay"
			audio.volume_db = 0.0
			audio.stream = load("res://Game Stuff/Sound/Sound Effects/yay-6326.mp3")
	else:
		if scream_type != "death":
			scream_type = "death"
			audio.volume_db = 20.0
			audio.stream = load("res://Game Stuff/Sound/Sound Effects/scream-85294.mp3")
	if world.score > 71 and world.score < 100: sword.visible = true
	else: sword.visible = false	


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
		if Input.is_action_pressed("down"):
			velocity.y += gravity*2
		
	if touching_ground.get_overlapping_bodies().size() == 0: ani.play("Fall")
	elif Input.is_action_pressed("up"):
		jump.play()
		ani.play("Jump")
		velocity.y = -1*jump_height
		turn_on_wide_collision()
	
	velocity.x = dir*speed
	move_and_slide()
	
	if global_position.y >= 200.0 and !audio.playing:
		world.youhere.global_position = global_position
		
		if world.score > 71 and world.score < 100:
			if fake_world.side == "left" and dragons1.position.y > -100:
				if global_position.x < 0: world.dragons_slayed += 1
				fake_world.hide_dragons()
				pop.play()
			elif fake_world.side == "right" and dragons2.position.y > -100:
				if global_position.x > 0: world.dragons_slayed += 1
				fake_world.hide_dragons()
				pop.play()
		
		audio.play()
	
	
	
	if global_position.y >= 450.0 and ! far_enough:
		world.score += 1
		world.save_score()
		far_enough = true
	

	
func turn_on_wide_collision():
	#if !skinny_collision.disabled: skinny_collision.disabled = true
	if !skinny_stand_collision.disabled:	skinny_stand_collision.disabled = true
	if wide_collision.disabled: wide_collision.disabled = false
	if wide_stand_collision.disabled: wide_stand_collision.disabled = false

func turn_on_skinny_collision():
	#if skinny_collision.disabled: skinny_collision.disabled = false
	if skinny_stand_collision.disabled:	skinny_stand_collision.disabled = false
	if !wide_collision.disabled: wide_collision.disabled = true
	if !wide_stand_collision.disabled: wide_stand_collision.disabled = true
