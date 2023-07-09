extends Node2D

onready var door = $door

onready var tutorial_layer = $tutorial_layer
onready var player = $ysort/player
onready var game_interface = $game_interface
onready var menu_confirm_sfx = $menu_confirm_sfx

onready var npc = $ysort/new_npc_1
onready var computer = $ysort/new_computer_1

var task_1 = false

func _init():
	pass
	
func _ready():
	player.freeze()
	tutorial_layer.visible = true
	game_interface.visible = false
	game_interface.set_level_text(1)

func _process(delta):
	if task_1:
		door.open = true
		Player.unlock_level("2")

# game interface
func _on_game_interface_freeze():
	player.freeze()

func _on_game_interface_unfreeze():
	player.unfreeze()

# tutorial layer
func _on_continue_pressed():
	menu_confirm_sfx.play()
	tutorial_layer.visible = false
	game_interface.visible = true
	player.unfreeze()

# npc
func _on_new_npc_1_start_solving():
	computer.enable()

func _on_new_npc_1_freeze_player():
	player.freeze()
	game_interface.visible = false

func _on_new_npc_1_unfreeze_player():
	player.unfreeze()
	game_interface.visible = true

# computer
func _on_new_computer_1_quest_done():
	task_1 = true
	npc.set_dialogue_page(1)

func _on_new_computer_1_freeze_player():
	player.freeze()
	game_interface.visible = false

func _on_new_computer_1_unfreeze_player():
	player.unfreeze()
	game_interface.visible = true


