extends Node

signal player_move(direction, times)

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
