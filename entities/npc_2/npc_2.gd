extends StaticBody2D

signal quest_done()
signal freeze_player()
signal unfreeze_player()

export(Array,String,FILE, "*.json") var dialogue_files
export(String) var npc_name

onready var dialogue = $dialogue
onready var interact_button = $interact_button
onready var problem_solver = $problem_solver
onready var feedback = $problem_solver/control/code_panel/code_feedback
onready var problem_solver_2 = $problem_solver_2
onready var feedback_2 = $problem_solver_2/control/code_panel/code_feedback

var interacting = false
var player = null
var player_in_range = false
var finished = false

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
		var name = Player.get_name()
		if not finished:
			dialogue.start(0,{"name": name})
		else:
			dialogue.start(3)

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
	if (page == 0):
		problem_solver.start()
	elif (page == 1):
		problem_solver_2.start()
	elif (page == 2):
		interacting = false
		emit_signal("unfreeze_player")
		emit_signal("quest_done")
		finished = true
	elif (page == 3):
		interacting = false
		emit_signal("unfreeze_player")

func _on_problem_solver_finish_problem(output, is_good):
	if ("get_name" in output):
		problem_solver.stop()
		var name = Player.get_name()
		dialogue.start(1,{"name": name})
	else:
		feedback.text = output

func _on_problem_solver_2_finish_problem(output, is_good):
	if (is_good):
		problem_solver_2.stop()
		dialogue.start(2)
	else:
		feedback_2.text = output

