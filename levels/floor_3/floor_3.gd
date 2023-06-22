extends Node2D

onready var door = $door
onready var bodyguard = $bodyguard

onready var player = $ysort/player
onready var game_interface = $game_interface

var task_1 = false
var task_2 = false
var task_3 = false

func _ready():
	game_interface.visible = true

func _process(delta):
	if task_1 and task_2 and task_3:
		bodyguard.working_elevator = true
		door.open = true

func _on_computer_quest_done():
	task_1 = true

func _on_computer_2_quest_done():
	task_2 = true

func _on_computer_3_quest_done():
	task_3 = true

func _on_game_interface_freeze():
	player.freeze()

func _on_game_interface_unfreeze():
	player.unfreeze()

func _on_computer_freeze_player():
	player.freeze()
	game_interface.visible = false

func _on_computer_unfreeze_player():
	player.unfreeze()
	game_interface.visible = true

