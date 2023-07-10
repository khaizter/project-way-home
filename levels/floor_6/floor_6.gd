extends Node2D

onready var door = $door

onready var player = $ysort/player
onready var game_interface = $game_interface

onready var npc = $ysort/new_npc_4
onready var computer = $ysort/new_computer_7

var task_1 = false

func _ready():
	game_interface.visible = true
	game_interface.set_level_text(4)

func _process(delta):
	if task_1:
		door.open = true
		Player.unlock_level("5")

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

func _on_new_computer_7_quest_done():
	task_1 = true
	npc.set_dialogue_page(1)


func _on_new_npc_4_freeze_player():
	player.freeze()
	game_interface.visible = false


func _on_new_npc_4_unfreeze_player():
	player.unfreeze()
	game_interface.visible = true


func _on_new_npc_4_start_solving():
	computer.enable()
