extends Node2D

var save_path_screams = "user://variable.screams"


var save_path_score = "user://variable.score"

var screams = 0
var score = 0

@onready var audio = $"Background music"
@onready var so_called_score = $CanvasLayer/Scorer
@onready var Narrator = $CanvasLayer/Narrator
@onready var Icon1 = $CanvasLayer/Icon1
@onready var youhere = $"you got here"
@onready var distancetext = $"you got here/distance"

@onready var basic_label = $CanvasLayer/Label

@onready var swordthingie = $CanvasLayer/swords

var dragons_slayed = 0

var fake_world = preload("res://Game Stuff/Scenes/fake_world.tscn")

var music_type = "calm"

var exit = 0

func _ready() -> void:
	#save_score()
	load_data_screams()
	audio.play()
	load_data_score()
	reset()
	Narrator.text = " "
	randomize()
	
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("exit"):
		exit += 1
		if exit >= 50:
			get_tree().change_scene_to_file("res://Game Stuff/Scenes/main_menu.tscn")
	else: exit = 0
	
	

	if Input.is_action_just_pressed("restart_world"):
		Narrator.text = ""
		score = 0
		save_score()
		reset()
		
		
		
	so_called_score.text = "%d" % score
	
	if score > 57 and score < 71:
		youhere.visible = true
		distancetext.text = "%d" % abs(youhere.global_position.x)
	else:
		youhere.visible = false
	
	if score > 71 and score < 100:
		basic_label.text = "%d" % dragons_slayed
		swordthingie.visible = true
	else: 
		basic_label.text = ""
		swordthingie.visible = false
	
	
	if score >= 20 and score <= 51:
		Icon1.texture = load("res://Game Stuff/Assets/Skull for Insanity.png")
		Icon1.visible = true
	elif score >= 52 and score <= 55:
		Icon1.texture = load("res://Game Stuff/Assets/Cool Diving for Insanity.png")
		Icon1.visible = true
	elif score > 71 and score < 80:
		Icon1.texture = load("res://Game Stuff/Assets/Dragon Head for Insanity.png")
		Icon1.visible = true
	elif score >= 80 and score < 100:
		Icon1.texture = load("res://Game Stuff/Assets/Dragon Head for Insanity (1).png")
		Icon1.visible = true
	else:
		Icon1.visible = false
	
	if score > 70 and score < 100:
		if music_type != "GLORIOUS":
			music_type = "GLORIOUS"
			audio.stream = load("res://Game Stuff/Sound/Music/medieval-kingdom-loop-366815.mp3")
			audio.volume_db = -5.0
			audio.play()
	else:
		if music_type != "calm":
			music_type = "calm"
			audio.stream = load("res://Game Stuff/Sound/Music/birds-chirping-calm-173695.mp3")
			audio.volume_db = 0
			audio.play()
	
	
	
	if score > 9:
		if score <= 19:
			Narrator.text = "Oh, I'm late! Sorry, sorry, you must be terribly confused!"
		elif score <= 20:
			Narrator.text = "Oh my, you certainly have been busy. You died %d times!" % score
		elif  score <= 23:
			Narrator.text = "Well, don't let me stop you! I'm sure whatever you are doing is very important."
		elif  score == 24:
			Narrator.text = ""
		elif  score == 25:
			Narrator.text = "..."
		elif  score <= 28:
			Narrator.text = "Are you trying to reach another platform? You keep missing it."
		elif  score <= 30:
			Narrator.text = "Maybe try a running start?"
		elif  score <= 32:
			Narrator.text = "Oh, nevermind."
		elif  score <= 36:
			Narrator.text = ""
		elif  score <= 38:
			Narrator.text = "Oh! I got it! You're trying to fall!"
		elif  score <= 48:
			Narrator.text = "You are very good at falling."
		elif  score <= 50:
			Narrator.text = "Oh! You aren't dying, you are diving! You're a sky diver!"
		elif  score <= 51:
			Narrator.text = "Let me adjust that, and move that there..."
		elif  score <= 52:
			Narrator.text = "Perfect!"
		elif  score <= 55:
			Narrator.text = "What do you think?"
		elif  score <= 56:
			Narrator.text = "No, that doesn't fit either!"
		elif  score <= 58:
			Narrator.text = "Wait! I have an idea! I'll be right back. While you wait, see how far you can get!"
		elif  score <= 70:
			Narrator.text = ""
		elif  score <= 71:
			Narrator.text = "TA-DAAAA!!!"
		elif  score <= 74:
			Narrator.text = "BRAVE KNIGHT! Dragons are storming the castle! Defeat them before they inflate!!"
		elif  score <= 76:
			Narrator.text = "Listen, the inflatable dragons were on sale! Stop questioning me, you'll miss the dragons!"
		elif  score <= 99:
			Narrator.text = "Make sure to HOLD DOWN so that you can slice through the dragons as fast as possible."
		elif  score == 100:
			Narrator.text = "Nice job! You slew %d dragons!" % dragons_slayed






func save_score():
	var file = FileAccess.open(save_path_score, FileAccess.WRITE)
	file.store_var(score)


func load_data_score():
	if FileAccess.file_exists(save_path_score):
		var file = FileAccess.open(save_path_score, FileAccess.READ)
		score = file.get_var()

func save_screams():
	var file = FileAccess.open(save_path_screams, FileAccess.WRITE)
	file.store_var(screams)


func load_data_screams():
	if FileAccess.file_exists(save_path_screams):
		var file = FileAccess.open(save_path_screams, FileAccess.READ)
		screams = file.get_var()



func reset():
	if has_node("Fake_world"):
		var faky = get_node("Fake_world")
		for child in faky.get_children(): child.queue_free()
		faky.queue_free()
	await get_tree().process_frame
	var new_world = fake_world.instantiate()
	new_world.name = "Fake_world"
	add_child(new_world)
	


func _on_background_music_finished() -> void:
	audio.play()
