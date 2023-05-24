extends Node2D

onready var door = $door

var task_1 = false

func _process(delta):
	if task_1:
		door.open = true

func _on_npc_quest_done():
	task_1 = true
