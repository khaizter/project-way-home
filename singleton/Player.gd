extends Node

signal player_move(direction, times)

var data_name = "Player"

var levels = {1 : true, 2 : true, 3  : true, 4 : true, 5 : false}

func _ready():
	pass

func set_name(value):
	data_name = value

func get_name():
	return data_name
	
func unlock_level(value):
	levels[value] = true

func is_level_unlocked(value):
	return levels[value]
