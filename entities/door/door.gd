extends Area2D

export var level:PackedScene

func _ready():
	pass


func _on_door_body_entered(body):
	if (level):
		get_tree().change_scene_to(level)
