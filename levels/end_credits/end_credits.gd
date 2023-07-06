extends CanvasLayer


func _ready():
	pass


func _on_continue_button_pressed():
	get_tree().change_scene("res://levels/main_menu/main_menu.tscn")
