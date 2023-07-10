extends Node2D

onready var door = $door

onready var player = $ysort/player
onready var game_interface = $game_interface

onready var npc = $ysort/new_npc_5
onready var computer_1 = $ysort/new_computer_8
onready var computer_2 = $ysort/new_computer_9

var task_1 = false
var task_2 = false

func _ready():
	game_interface.visible = true
	game_interface.set_level_text(5)

func _process(delta):
	if task_1 and task_2:
		door.open = true
		Player.unlock_level("6")

func _on_game_interface_freeze():
	player.freeze()

func _on_game_interface_unfreeze():
	player.unfreeze()

func _on_new_computer_freeze_player():
	player.freeze()
	game_interface.visible = false

func _on_new_computer_unfreeze_player():
	player.unfreeze()
	game_interface.visible = true

func _on_new_computer_8_quest_done():
	task_1 = true
	computer_2.enable()

func _on_new_computer_9_quest_done():
	task_2 = true
	npc.set_dialogue_page(1)

func _on_new_npc_5_freeze_player():
	player.freeze()
	game_interface.visible = false

func _on_new_npc_5_unfreeze_player():
	player.unfreeze()
	game_interface.visible = true


func _on_new_npc_5_start_solving():
	computer_1.enable()
