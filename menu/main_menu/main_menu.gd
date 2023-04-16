extends Control

export var level:PackedScene

func _on_start_button_pressed():
	if (level):
		get_tree().change_scene_to(level)


func _on_exit_button_pressed():
	get_tree().quit()
