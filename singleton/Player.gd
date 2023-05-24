extends Node

signal player_move(direction, times)

var data_name = "undefined"

func _ready():
	pass

func moveRight(times = 1):
	emit_signal("player_move", Vector2.RIGHT, times)

func moveLeft(times = 1):
	emit_signal("player_move", Vector2.LEFT, times)

func moveUp(times = 1):
	emit_signal("player_move", Vector2.UP, times)
	
func moveDown(times = 1):
	emit_signal("player_move", Vector2.DOWN, times)


func set_name(value):
	data_name = value

func get_name():
	return data_name
