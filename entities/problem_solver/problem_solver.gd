extends CanvasLayer

signal finish_problem(output, is_good)

export(String, MULTILINE) var tutorial_text
export(String, MULTILINE) var initial_code
export(String, MULTILINE) var checker

onready var code_panel = $control/code_panel
onready var code_editor = $control/code_panel/code_editor
onready var code_feedback = $control/code_panel/code_feedback
onready var run_button = $control/code_panel/run_button
onready var reset_button = $control/code_panel/reset_button
onready var tutorial_panel = $control/tutorial_panel
onready var tutorial = $control/tutorial_panel/tutorial

const SCRIPT_FILE = "res://script.py"

const SCRIPT_TEMPLATE = "import sys\ndef eval():\n\ttry:\n#initial\n\t\t#code\n#checker\n\texcept Exception as error:\n\t\treturn [type(error).__name__ + '-' + str(error),False]\nres = eval()\nsys.stdout.write(res[0] + '^' + str(res[1]))"

func _ready():
	tutorial.text = tutorial_text
	tutorial_panel.visible = true
	code_panel.visible = false
	visible = false
	
func start():
	visible = true

func stop():
	visible = false

func _on_run_button_pressed():
	var result = evaluate_code(code_editor.text).split("^")
	print("test",result)
	emit_signal("finish_problem",result[0], result[1] == 'True')

func _on_reset_button_pressed():
	code_editor.text = ''
	pass # Replace with function body.

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

func _on_gotit_button_pressed():
	code_panel.visible = true
	tutorial_panel.visible = false


func _on_back_button_pressed():
	code_panel.visible = false
	tutorial_panel.visible = true
