extends CanvasLayer

signal freeze()
signal unfreeze()

onready var main_layer = $main
onready var menu_layer = $menu

func _ready():
	main_layer.visible = true
	menu_layer.visible = false

func _on_menu_pressed():
	main_layer.visible = false
	menu_layer.visible = true
	emit_signal("freeze")

func _on_main_menu_button_pressed():
	get_tree().change_scene("res://levels/main_menu/main_menu.tscn")


func _on_exit_game_button_pressed():
	get_tree().quit()


func _on_continue_button_pressed():
	main_layer.visible = true
	menu_layer.visible = false
	emit_signal("unfreeze")
