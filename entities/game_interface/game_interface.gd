extends CanvasLayer

signal freeze()
signal unfreeze()

export(Array,String, MULTILINE) var notes_data

export(String, MULTILINE) var tutorial_text
export(String, MULTILINE) var initial_code
export(String, MULTILINE) var checker

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
onready var page_6_button = $diary/page_selector/page_6
onready var page_7_button = $diary/page_selector/page_7
onready var page_8_button = $diary/page_selector/page_8


onready var code_editor = $phone/code_editor
onready var code_feedback = $phone/code_feedback

onready var level = $main/level

const SCRIPT_FILE = "res://script.py"

const SCRIPT_TEMPLATE = "import sys\ndef eval():\n\ttry:\n#initial\n\t\t#code\n#checker\n\texcept Exception as error:\n\t\treturn [type(error).__name__ + '-' + str(error),False]\nres = eval()\nsys.stdout.write(res[0] + '^' + str(res[1]))"


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
	page_6_button.disabled = not Player.is_level_unlocked("6")
	page_7_button.disabled = not Player.is_level_unlocked("7")
	page_8_button.disabled = not Player.is_level_unlocked("8")
	

func set_level_text(value):
	level.text = 'Level ' + str(value)

func _on_menu_pressed():
	SoundMaster.play("menu_confirm")
	main_layer.visible = false
	menu_layer.visible = true
	emit_signal("freeze")

func _on_main_menu_button_pressed():
	SoundMaster.play("menu_confirm")
	get_tree().change_scene("res://levels/main_menu/main_menu.tscn")

func _on_exit_game_button_pressed():
	SoundMaster.play("menu_back")
	get_tree().quit()

func _on_continue_button_pressed():
	SoundMaster.play("menu_back")
	main_layer.visible = true
	menu_layer.visible = false
	emit_signal("unfreeze")

func _on_diary_button_pressed():
	SoundMaster.play("menu_confirm")
	main_layer.visible = false
	diary_layer.visible = true
	emit_signal("freeze")

func _on_close_diary_button_pressed():
	SoundMaster.play("menu_back")
	main_layer.visible = true
	diary_layer.visible = false
	emit_signal("unfreeze")

func _on_phone_button_pressed():
	SoundMaster.play("menu_confirm")
	main_layer.visible = false
	phone_layer.visible = true
	emit_signal("freeze")

func _on_close_phone_button_pressed():
	SoundMaster.play("menu_back")
	main_layer.visible = true
	phone_layer.visible = false
	emit_signal("unfreeze")


func _on_page_1_pressed():
	SoundMaster.play("page_confirm")
	notes.text = notes_data[0]
	page_layer.visible = false
	notes_layer.visible = true

func _on_page_2_pressed():
	SoundMaster.play("page_confirm")
	notes.text = notes_data[1]
	page_layer.visible = false
	notes_layer.visible = true

func _on_page_3_pressed():
	SoundMaster.play("page_confirm")
	notes.text = notes_data[2]
	page_layer.visible = false
	notes_layer.visible = true

func _on_page_4_pressed():
	SoundMaster.play("page_confirm")
	notes.text = notes_data[3]
	page_layer.visible = false
	notes_layer.visible = true

func _on_page_5_pressed():
	SoundMaster.play("page_confirm")
	notes.text = notes_data[4]
	page_layer.visible = false
	notes_layer.visible = true


func _on_page_6_pressed():
	SoundMaster.play("page_confirm")
	notes.text = notes_data[5]
	page_layer.visible = false
	notes_layer.visible = true

func _on_page_7_pressed():
	SoundMaster.play("page_confirm")
	notes.text = notes_data[6]
	page_layer.visible = false
	notes_layer.visible = true

func _on_page_8_pressed():
	SoundMaster.play("page_confirm")
	notes.text = notes_data[7]
	page_layer.visible = false
	notes_layer.visible = true

func _on_back_to_page_button_pressed():
	SoundMaster.play("page_back")
	page_layer.visible = true
	notes_layer.visible = false


func _on_run_phone_button_pressed():
	var result = evaluate_code(code_editor.text).split("^")
	print("test ",result)
#	emit_signal("finish_problem",result[0], result[1] == 'True')
	if "default_output" in result[0]:
		code_feedback.text = result[0].replace('default_output','')
		pass
	else:
		code_feedback.text = result[0]


func _on_reset_phone_button_pressed():
	code_editor.text = ''

func evaluate_code(input):
	# do transformations on user script and check script
	
	var initial_script = initial_code
	initial_script = '\t\t' + initial_script.replace("\n","\n\t\t")
	
	var regex = RegEx.new()
	regex.compile("input\\(.*\\)")
	
	var user_script = input
	user_script = "exec('''" + regex.sub(user_script.replace("\'","\""), '"input-field"',true) + "''',globals(),ldict)"
	
	var check_script = checker	
	check_script = '\t\t' + check_script.replace("\n","\n\t\t")
	
	# edit script.py
	var file = File.new()
	file.open(SCRIPT_FILE,File.WRITE)
	var new_script = SCRIPT_TEMPLATE.replace("#code", user_script).replace("#checker",check_script).replace("#initial",initial_script)
	file.store_string(new_script)
	file.close()
 
	# evaluate code
	var global_dir_path = ProjectSettings.globalize_path("res://")
	var stdout = []
	var exit = OS.execute("python",[global_dir_path + "/script.py"],true , stdout,true)
	return stdout[0]








