extends CanvasLayer

export(String,MULTILINE) var tutorial_text
export(String,MULTILINE) var checker

onready var code_editor = $control/code_editor
onready var code_feedback = $control/code_feedback
onready var run_button = $control/run_button
onready var reset_button = $control/reset_button
onready var tutorial_background = $control/tutorial_background
onready var tutorial = $control/tutorial_background/tutorial

const SCRIPT_FILE = "res://script.py"

const SCRIPT_TEMPLATE = "import sys\ndef eval():\n\ttry:\n#code\n\t\tpassed = False\n#checker\n\t\treturn str(passed)\n\texcept:\n\t\treturn 'Invalid Syntax'\nsys.stdout.write(eval())"

func _ready():
	tutorial_background.visible = true
	tutorial.text = tutorial_text


func _on_run_button_pressed():
	print(evaluate_code(code_editor.text))

func _on_reset_button_pressed():
	code_editor.text = ''
	pass # Replace with function body.


func evaluate_code(input):
	# do transformations on user script and check script
	var user_script = input
	user_script = '\t\t' + user_script.replace("\n","\n\t\t")
	
	var check_script = checker
	check_script = '\t\t' + check_script.replace("\n","\n\t\t")
	
	# edit script.py
	var file = File.new()
	file.open(SCRIPT_FILE,File.WRITE)
	var new_script = SCRIPT_TEMPLATE.replace("#code", user_script).replace("#checker",check_script)
	file.store_string(new_script)
	file.close()

	# evaluate code
	var global_dir_path = ProjectSettings.globalize_path("res://")
	var stdout = []
	var exit = OS.execute("python",[global_dir_path + "/script.py"],true , stdout,true)
	return stdout[0]


func _on_gotit_button_pressed():
	tutorial_background.visible = false
