extends StaticBody2D

signal quest_done()

onready var interact_button = $control/interact_button
onready var problem_solver = $problem_solver
onready var feedback = $problem_solver/control/code_feedback

var interacting = false
var player = null
var player_in_range = false

func _ready():
	interact_button.visible = false

func _process(delta):
	interact_button.visible = player_in_range

func interaction():
	if (not interacting):
		interacting = true
		player.set_physics_process(false)
		problem_solver.start()

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

func _on_problem_solver_finish_problem(output, is_good):
	if ("0\r\n1\r\n2\r\n3\r\n4\r\n" in output):
		problem_solver.stop()
		interacting = false
		player.set_physics_process(true)
		emit_signal("quest_done")
	else:
		feedback.text = output
