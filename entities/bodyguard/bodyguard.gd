extends StaticBody2D

export(Array,String,FILE, "*.json") var dialogue_files
export(String) var npc_name

onready var dialogue = $dialogue
onready var interact_button = $interact_button

var interacting = false
var player = null
var player_in_range = false

var working_elevator = false

func _ready():
	interact_button.visible = false
	dialogue.initialize_dialogues(dialogue_files)

func _process(delta):
	interact_button.visible = player_in_range

func interaction():
	if (not interacting):
		interacting = true
		player.set_physics_process(false)
		if not working_elevator:
			dialogue.start(0)
		else:
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
	interacting = false
	player.set_physics_process(true)
