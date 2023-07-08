extends StaticBody2D

signal freeze_player()
signal unfreeze_player()
signal start_solving()

export(Array,String,FILE, "*.json") var dialogue_files

onready var dialogue = $dialogue
onready var interact_button = $interact_button
onready var lesson_module = $lesson_module

var interacting = false
var player = null
var player_in_range = false

var current_page = 0

func _ready():
	interact_button.visible = false
	dialogue.initialize_dialogues(dialogue_files)

func _process(delta):
	interact_button.visible = player_in_range

func interaction():
	if (not interacting):
		interacting = true
		print('npc begin interact')
		emit_signal("freeze_player")
		if current_page == 0:
			dialogue.start(0)
		elif current_page == 1:
			dialogue.start(1)

func _on_interact_area_body_entered(body):
	if body.is_in_group("player"):
		player = body
		player_in_range = true
		body.connect("player_interact",self,"interaction")

func _on_interact_area_body_exited(body):
	if body.is_in_group("player"):
		player = null
		player_in_range = false
		body.disconnect("player_interact",self,"interaction")

func _on_dialogue_finish_dialogue(page):
	if page == 0:
		lesson_module.show()
	elif page == 1:
		interacting = false
		emit_signal("unfreeze_player")
	pass

func _on_lesson_module_hide():
	interacting = false
	emit_signal("unfreeze_player")
	emit_signal("start_solving")
	
func set_dialogue_page(value):
	current_page = value
