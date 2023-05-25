extends Node2D

onready var door = $door

var task_1 = false
var task_2 = false
var task_3 = false

func _process(delta):
	if task_1 and task_2 and task_3:
		door.open = true

func _on_computer_quest_done():
	task_1 = true


func _on_computer_2_quest_done():
	task_2 = true


func _on_computer_3_quest_done():
	task_3 = true
