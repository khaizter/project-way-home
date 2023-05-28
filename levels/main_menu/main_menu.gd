extends CanvasLayer

export var level:PackedScene

func _ready():
	pass


func _on_start_button_pressed():
	if (level):
		get_tree().change_scene_to(level)
