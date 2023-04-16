extends Button

export var level:PackedScene

func _on_level_button_pressed():
	if (level):
		get_tree().change_scene_to(level)
