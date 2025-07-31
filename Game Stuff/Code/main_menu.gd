extends Node2D

@onready var sprite = $Sprite2D

@onready var main_buttons = $Buttons

@onready var exit_button = $Exit

var locked: bool = true


func _ready() -> void:
	if locked: sprite.frame = 0
	else: sprite.frame = 1

func _on_controls_pressed() -> void:
	sprite.frame = 2.0
	main_buttons.visible = false
	exit_button.visible = true


func _on_begin_pressed() -> void:
	pass # Replace with function body.


func _on_level_select_pressed() -> void:
	if locked: pass


func _on_credits_pressed() -> void:
	sprite.frame = 3
	main_buttons.visible = false
	exit_button.visible = true


func _on_exit_pressed() -> void:
	main_buttons.visible = true
	exit_button.visible = false
	if locked: sprite.frame = 0
	else: sprite.frame = 1
