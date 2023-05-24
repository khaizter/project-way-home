extends Area2D

export(Array,String,FILE, "*.json") var dialogue_files
export(String) var npc_name

onready var dialogue = $dialogue
onready var interact_button = $control/interact_button
onready var problem_solver = $problem_solver
onready var feedback = $problem_solver/control/code_feedback

var interacting = false
var player = null
var player_in_range = false

func _ready():
	interact_button.visible = false
	dialogue.initialize_dialogues(dialogue_files)

func _process(delta):
	interact_button.visible = player_in_range
	
func interaction():
	if (not interacting):
		interacting = true
		print('npc begin interact')
		player.set_physics_process(false)
		dialogue.start(0)

func _on_npc_2_body_entered(body):
	if body.is_in_group("player"):
		player = body
		player_in_range = true
		body.connect("player_interact",self,"interaction")

func _on_npc_2_body_exited(body):
	if body.is_in_group("player"):
		player = null
		player_in_range = false
		body.disconnect("player_interact",self,"interaction")


func _on_dialogue_finish_dialogue(page):
	pass # Replace with function body.


func _on_problem_solver_finish_problem(output, is_good):
	pass # Replace with function body.
