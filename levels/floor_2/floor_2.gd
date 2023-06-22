extends Node2D

onready var door = $door

onready var player = $ysort/player
onready var game_interface = $game_interface

var task_1 = false

func _ready():
	game_interface.visible = true

func _process(delta):
	if task_1:
		door.open = true

func _on_npc_2_quest_done():
	task_1 = true


func _on_game_interface_freeze():
	player.freeze()


func _on_game_interface_unfreeze():
	player.unfreeze()


func _on_npc_2_freeze_player():
	player.freeze()
	game_interface.visible = false

func _on_npc_2_unfreeze_player():
	player.unfreeze()
	game_interface.visible = true
