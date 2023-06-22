extends Node2D

onready var door = $door

onready var tutorial_layer = $tutorial_layer
onready var player = $ysort/player
onready var game_interface = $game_interface

var task_1 = false

func _ready():
	player.freeze()
	tutorial_layer.visible = true
	game_interface.visible = false

func _process(delta):
	if task_1:
		door.open = true
		Player.unlock_level("2")

func _on_npc_quest_done():
	task_1 = true

func _on_continue_pressed():
	tutorial_layer.visible = false
	game_interface.visible = true
	player.unfreeze()

func _on_game_interface_freeze():
	player.freeze()

func _on_game_interface_unfreeze():
	player.unfreeze()

func _on_npc_freeze_player():
	player.freeze()
	game_interface.visible = false

func _on_npc_unfreeze_player():
	player.unfreeze()
	game_interface.visible = true
