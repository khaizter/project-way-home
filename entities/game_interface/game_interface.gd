extends CanvasLayer

signal freeze()
signal unfreeze()

export(Array,String, MULTILINE) var notes_data

onready var main_layer = $main
onready var menu_layer = $menu
onready var diary_layer = $diary
onready var phone_layer = $phone

onready var page_layer = $diary/page_selector
onready var notes_layer = $diary/notes_layer
onready var notes = $diary/notes_layer/notes

onready var page_1_button = $diary/page_selector/page_1
onready var page_2_button = $diary/page_selector/page_2
onready var page_3_button = $diary/page_selector/page_3
onready var page_4_button = $diary/page_selector/page_4
onready var page_5_button = $diary/page_selector/page_5

onready var menu_confirm_sfx = $menu_confirm_sfx
onready var menu_back_sfx = $menu_back_sfx
onready var page_confirm_sfx = $page_confirm_sfx
onready var page_back_sfx = $page_back_sfx

func _ready():
	main_layer.visible = true
	menu_layer.visible = false
	diary_layer.visible = false
	phone_layer.visible = false
	
	page_layer.visible = true
	notes_layer.visible = false
	
	page_1_button.disabled = not Player.is_level_unlocked("1")
	page_2_button.disabled = not Player.is_level_unlocked("2")
	page_3_button.disabled = not Player.is_level_unlocked("3")
	page_4_button.disabled = not Player.is_level_unlocked("4")
	page_5_button.disabled = not Player.is_level_unlocked("5")

func _on_menu_pressed():
	menu_confirm_sfx.play()
	main_layer.visible = false
	menu_layer.visible = true
	emit_signal("freeze")

func _on_main_menu_button_pressed():
	menu_confirm_sfx.play()
	get_tree().change_scene("res://levels/main_menu/main_menu.tscn")

func _on_exit_game_button_pressed():
	menu_back_sfx.play()
	get_tree().quit()

func _on_continue_button_pressed():
	menu_back_sfx.play()
	main_layer.visible = true
	menu_layer.visible = false
	emit_signal("unfreeze")

func _on_diary_button_pressed():
	menu_confirm_sfx.play()
	main_layer.visible = false
	diary_layer.visible = true
	emit_signal("freeze")

func _on_close_diary_button_pressed():
	menu_back_sfx.play()
	main_layer.visible = true
	diary_layer.visible = false
	emit_signal("unfreeze")

func _on_phone_button_pressed():
	menu_confirm_sfx.play()
	main_layer.visible = false
	phone_layer.visible = true
	emit_signal("freeze")

func _on_close_phone_button_pressed():
	menu_back_sfx.play()
	main_layer.visible = true
	phone_layer.visible = false
	emit_signal("unfreeze")


func _on_page_1_pressed():
	page_confirm_sfx.play()
	notes.text = notes_data[0]
	page_layer.visible = false
	notes_layer.visible = true

func _on_page_2_pressed():
	page_confirm_sfx.play()
	notes.text = notes_data[1]
	page_layer.visible = false
	notes_layer.visible = true

func _on_page_3_pressed():
	page_confirm_sfx.play()
	notes.text = notes_data[2]
	page_layer.visible = false
	notes_layer.visible = true

func _on_page_4_pressed():
	page_confirm_sfx.play()
	notes.text = notes_data[3]
	page_layer.visible = false
	notes_layer.visible = true

func _on_page_5_pressed():
	page_confirm_sfx.play()
	notes.text = notes_data[4]
	page_layer.visible = false
	notes_layer.visible = true


func _on_back_to_page_button_pressed():
	page_back_sfx.play()
	page_layer.visible = true
	notes_layer.visible = false
