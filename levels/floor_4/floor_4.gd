extends Node2D

onready var door = $door
onready var bodyguard = $bodyguard

var task_1 = false
var task_2 = false

func _process(delta):
	if task_1 and task_2:
		bodyguard.working_elevator = true
		door.open = true


func _on_database_quest_done():
	task_1 = true


func _on_database_2_quest_done():
	task_2 = true
