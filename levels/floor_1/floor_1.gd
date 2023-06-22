extends Node2D

onready var door = $door

onready var tutorial_layer = $tutorial_layer
onready var player = $ysort/player

var task_1 = false

func _ready():
	player.freeze()
	tutorial_layer.visible = true

func _process(delta):
	if task_1:
		door.open = true

func _on_npc_quest_done():
	task_1 = true

func _on_continue_pressed():
	tutorial_layer.visible = false
	player.unfreeze()
