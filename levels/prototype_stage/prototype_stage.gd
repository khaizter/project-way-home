extends Node2D

onready var player = $ysort/player
onready var game_interface = $game_interface

var task_1 = false

func _ready():
	game_interface.visible = true

func _process(delta):
	if task_1:
		# door is open
		pass

func _on_new_computer_1_freeze_player():
	player.freeze()
	game_interface.visible = false

func _on_new_computer_1_unfreeze_player():
	player.unfreeze()
	game_interface.visible = true

func _on_game_interface_freeze():
	player.freeze()

func _on_game_interface_unfreeze():
	player.unfreeze()

func _on_new_computer_1_quest_done():
	task_1 = true
