extends Node2D

export(Array,Array,String, MULTILINE) var notes_data

onready var player = $ysort/player
onready var game_interface = $game_interface
onready var door = $door
onready var npc = $ysort/new_npc_1
onready var computer = $ysort/new_computer_1


var task_1 = false

func _ready():
	game_interface.visible = true

func _process(delta):
	if task_1:
		door.open = true
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
	npc.set_dialogue_page(1)

func _on_new_npc_1_freeze_player():
	player.freeze()
	game_interface.visible = false

func _on_new_npc_1_unfreeze_player():
	player.unfreeze()
	game_interface.visible = true

func _on_new_npc_1_start_solving():
	computer.can_solve = true
