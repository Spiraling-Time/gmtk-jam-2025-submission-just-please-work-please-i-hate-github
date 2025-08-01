extends CharacterBody2D

@onready var world = get_tree().current_scene
@onready var sprite = $Sprite2D

func _ready() -> void:
	if (world.score > 70 and world.score < 110) or world.main_mode == "GLORY": sprite.texture = load("res://Game Stuff/Assets/Platforms for Insanity.png")
	else: sprite.texture = load("res://Game Stuff/Assets/Platforms for Insanity (1).png")
