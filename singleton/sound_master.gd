extends Node

onready var menu_confirm_sfx = $menu_confirm_sfx
onready var menu_back_sfx = $menu_back_sfx
onready var page_confirm_sfx = $page_confirm_sfx
onready var page_back_sfx = $page_back_sfx

func play(value):
	if value == "menu_confirm":
		menu_confirm_sfx.play()
	elif value == "menu_back":
		menu_back_sfx.play()
	elif value == "page_confirm":
		page_confirm_sfx.play()
	elif value == "page_back":
		page_back_sfx.play()
	else:
		print("invalid key")
