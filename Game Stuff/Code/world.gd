extends Node2D

var save_path_screams = "user://variable.screams"

var save_path_locked = "user://variable.locked"
var locked: bool = true


var save_path_score = "user://variable.score"

var screams = 0
var score = 0

@onready var voice = $Narrating

@onready var audio = $"Background music"
@onready var so_called_score = $CanvasLayer/Scorer
@onready var Narrator = $CanvasLayer/Narrator
@onready var Icon1 = $CanvasLayer/Icon1
@onready var youhere = $"you got here"
@onready var distancetext = $"you got here/distance"

@onready var basic_label = $CanvasLayer/Label

@onready var swordthingie = $CanvasLayer/swords

@onready var player = $Fake_world/Player

var dragons_slayed = 0

var fake_world = preload("res://Game Stuff/Scenes/fake_world.tscn")

var music_type = "calm"

var exit = 0

@onready var type_here = $CanvasLayer/LineEdit

var typed_level = 0


var main_mode = "Normal"
var icon_mode = "Normal"
var distance_mode:bool = false
var death_scream_mode: bool = false

var current_recording = preload("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 001.mp3")

func _ready() -> void:
	load_data_locked()
	#save_score()
	load_data_screams()
	audio.play()
	load_data_score()
	reset()
	Narrator.text = " "
	randomize()
	#print(screams)
	
func _physics_process(delta: float) -> void:
	so_called_score.text = "%d" % score
	
	
	if (score > 57 and score < 71) or distance_mode:
		if youhere.global_position != Vector2.ZERO:
			youhere.visible = true
			distancetext.text = "%d" % abs(youhere.global_position.x)
	else: youhere.visible = false
	
	if (score > 71 and score < 110) or main_mode == "GLORY":
		basic_label.text = "%d" % dragons_slayed
		swordthingie.visible = true
	else: 
		basic_label.text = ""
		swordthingie.visible = false
	
	
	if (score >= 20 and score <= 49) or icon_mode == "Skull":
		Icon1.texture = load("res://Game Stuff/Assets/Skull for Insanity.png")
		Icon1.visible = true
	elif (score >= 50 and score <= 55) or icon_mode == "Arrow":
		Icon1.texture = load("res://Game Stuff/Assets/Cool Diving for Insanity.png")
		Icon1.visible = true
	elif (score > 71 and score < 80) or icon_mode == "Dragon":
		Icon1.texture = load("res://Game Stuff/Assets/Dragon Head for Insanity.png")
		Icon1.visible = true
	elif score >= 80 and score < 110:
		Icon1.texture = load("res://Game Stuff/Assets/Dragon Head for Insanity (1).png")
		Icon1.visible = true
	else:
		Icon1.visible = false
	
	if (score > 70 and score < 110) or main_mode == "GLORY":
		if music_type != "GLORIOUS":
			music_type = "GLORIOUS"
			audio.stream = load("res://Game Stuff/Sound/Music/medieval-kingdom-loop-366815.mp3")
			audio.play()
	else:
		if music_type != "calm":
			music_type = "calm"
			audio.stream = load("res://Game Stuff/Sound/Music/birds-chirping-calm-173695.mp3")
			audio.play()
	
	
	
	if score > 9:
		if score <= 19:
			Narrator.text = "Oh, I'm late! Sorry, sorry, you must be terribly confused!"
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 001.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif score <= 20:
			Narrator.text = "Oh my, you certainly have been busy. You died %d times!" % score
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 002.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 23:
			Narrator.text = "Well, don't let me stop you! I'm sure whatever you are doing is very important."
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 003.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
				
		elif  score <= 24:
			Narrator.text = ""
		elif  score <= 25:
			Narrator.text = "..."
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 004.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 28:
			Narrator.text = "Are you trying to reach another platform? You keep missing it."
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 005.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
				
		elif  score <= 30:
			Narrator.text = "Maybe try a running start?"
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 006.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 32:
			Narrator.text = "Oh, nevermind."
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 007.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 36:
			Narrator.text = "Oh! I got it! You're trying to fall!"
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 008.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 38:
			Narrator.text = "You are very good at falling."
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 009.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 48:
			Narrator.text = "Oh! You aren't dying, you are diving! You're a sky diver!"
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 010.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 49:
			Narrator.text = "Let me adjust that, and move that there..."
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 011.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 54:
			Narrator.text = "Perfect!"
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 012.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 55:
			Narrator.text = "What do you think?"
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 013.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 56:
			Narrator.text = "No, that doesn't fit either!"
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 014.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 58:
			Narrator.text = "Wait! I have an idea! I'll be right back. While you wait, see how far you can get!"
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 015.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 70:
			Narrator.text = ""

		elif  score <= 71:
			Narrator.text = "TA-DAAAA!!!"
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 016.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 74:
			Narrator.text = "BRAVE KNIGHT! Dragons are storming the castle! Defeat them before they inflate!!"
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 017.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 76:
			Narrator.text = "Listen, the inflatable dragons were on sale! Stop questioning me, you'll miss the dragons!"
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 018.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 109:
			Narrator.text = "Make sure to HOLD DOWN so that you can slice through the dragons as fast as possible."
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 019.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 111:
			Narrator.text = "Nice job! You slew %d dragons!" % dragons_slayed
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 020.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
				
		elif  score <= 113:
			Narrator.text = "You should be proud of yourself!"
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 021.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 115:
			Narrator.text = "..."
		elif  score <= 117:
			Narrator.text = "You died, skydived, saw how far you could go, and fought dragons!"
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 022.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 119:
			Narrator.text = "You fell (or jumped) left or right."
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 023.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 121:
			Narrator.text = "Both are true."
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 024.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 123:
			Narrator.text = "You did the same thing over, and over, and over, and the only thing that changed was how you viewed it."
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 025.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 125:
			Narrator.text = "When something keeps occurring, it is NOT insane to expect something new. Even if nothing objectively changes, your perspective can change."
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 026.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 127:
			Narrator.text = "You do something 100 times, hear something 100 times, see something 100 times, and you could find something new."
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 027.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 129:
			Narrator.text = "This game is a small example of that. I hoped you learned something, or at least had some fun. Now, get up, and go perceive the world anew!"
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 028.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 131:
			Narrator.text = "Open a door, take a walk, touch some grass! Stop playing this! Look at everything differently!"
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 029.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 133:
			Narrator.text = "Go on! Shoo!"
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 030.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 135:
			Narrator.text = "..."
		elif  score <= 137:
			Narrator.text = "Oh, you want more? Fine. Here's some toggles, and a level select. Go back to the main menu to unlock them (HOLD SPACE)."
			locked = false
			save_locked()
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 031.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 139:
			Narrator.text = "Thats it."
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 032.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 139:
			Narrator.text = "Or really, thats everything. Make your own goals! (And head to the main menu if you want any of the modifiers present in the game)."
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 033.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 141:
			Narrator.text = "Can you yell in sync with your character?"
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 034.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 200:
			Narrator.text = ""
		elif  score <= 300:
			Narrator.text = "That's some dedication."
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 035.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 400:
			Narrator.text = "That's some serious dedication."
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 036.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 500:
			Narrator.text = "Comment an idea for a modifier to how the game looks and your favorite food. I'll check back and add in a few I like!"
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 037.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 600:
			Narrator.text = "Go touch grass."
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 038.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 750:
			Narrator.text = "Bye. I'm glad you are this invested, but I have stuff to do."
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 039.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score <= 1000:
			Narrator.text = "I said I have to go! Good day!"
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 040.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()
		elif  score == 1003:
			Narrator.text = "I'm not actually British."
			current_recording = load("res://Game Stuff/Sound/British narration/Record (online-voice-recorder.com) 041.mp3")
			if voice.stream != current_recording:
				voice.stream = current_recording
				voice.stop()
				voice.play()

	if !locked:
		if Input.is_action_just_pressed("restart_world"):
			type_here.visible = true
			save_score()
			reset()
		if Input.is_action_just_pressed("toggle_death_icon"):
			if icon_mode != "Skull": icon_mode = "Skull"
			else: icon_mode = "Normal"
			save_score()
			reset()
		if Input.is_action_just_pressed("toggle_arrow_and_joy"):
			if icon_mode != "Arrow": icon_mode = "Arrow"
			else: icon_mode = "Normal"
			if !death_scream_mode: death_scream_mode = true
			else: death_scream_mode = false
			save_score()
			reset()
		if Input.is_action_just_pressed("toggle_distance_tracker"):
			if !distance_mode: distance_mode = true
			else: distance_mode = false
			save_score()
			reset()
		if Input.is_action_just_pressed("toggle_dragons"):
			if main_mode != "GLORY": main_mode = "GLORY"
			else: main_mode = "Normal"
			save_score()
			reset()



	if type_here.visible:
		if type_here.text.is_valid_int():
			var intform = int(type_here.text)
			if intform >= 0: typed_level = intform
		if Input.is_action_just_pressed("select"):
			Narrator.text = ""
			score = typed_level
			save_score()
			reset()
			type_here.visible = false
			
	else:
		if Input.is_action_pressed("exit"):
			exit += 1
			if exit >= 50:
				get_tree().change_scene_to_file("res://Game Stuff/Scenes/main_menu.tscn")
		else: exit = 0




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
		faky.queue_free()
	await get_tree().process_frame
	var new_world = fake_world.instantiate()
	new_world.name = "Fake_world"
	add_child(new_world)
	


func _on_background_music_finished() -> void:
	audio.play()


func save_locked():
	var file = FileAccess.open(save_path_locked, FileAccess.WRITE)
	file.store_var(locked)

func load_data_locked():
	if FileAccess.file_exists(save_path_locked):
		var file = FileAccess.open(save_path_locked, FileAccess.READ)
		locked = file.get_var()
