extends Node2D

onready var door = $door

var task_1 = false
var task_2 = false

func _process(delta):
	if task_1 and task_2:
		door.open = true


func _on_database_quest_done():
	task_1 = true


func _on_database_2_quest_done():
	task_2 = true
