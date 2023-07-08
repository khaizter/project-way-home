extends StaticBody2D

signal quest_done()
signal freeze_player()
signal unfreeze_player()

onready var interact_button = $interact_button
onready var problem_solver = $problem_solver
onready var feedback = $problem_solver/control/code_panel/code_feedback
onready var check_mark = $check_mark

var interacting = false
var player = null
var player_in_range = false
var task_done = false

var can_solve = false

func _ready():
	interact_button.visible = false
	check_mark.visible = false

func _process(delta):
	interact_button.visible = player_in_range if not task_done else false
	check_mark.visible = player_in_range if task_done else false

func interaction():
	if task_done:
		return
	if (not interacting):
		if can_solve:
			interacting = true
			emit_signal("freeze_player")
			problem_solver.start()
		else:
			Notification.show_notification("Interact with Clark first")

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


func _on_problem_solver_finish_problem(output, is_good, index):
	if (is_good):
		problem_solver.stop()
		interacting = false
		emit_signal("unfreeze_player")
		emit_signal("quest_done")
		task_done = true
		Notification.show_notification("Task Complete!")
	else:
		feedback.text = output

func _on_problem_solver_close():
	problem_solver.stop()
	interacting = false
	emit_signal("unfreeze_player")

func enable():
	can_solve = true
