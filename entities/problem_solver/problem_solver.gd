extends CanvasLayer

signal finish_problem(output, is_good, index)
signal close()

export(Array,Array,String, MULTILINE) var problem_list

onready var code_panel = $control/code_panel
onready var code_editor = $control/code_panel/code_editor
onready var code_feedback = $control/code_panel/code_feedback
onready var run_button = $control/code_panel/run_button
onready var reset_button = $control/code_panel/reset_button
onready var tutorial_panel = $control/tutorial_panel
onready var tutorial = $control/tutorial_panel/tutorial

const SCRIPT_FILE = "res://script.py"

const SCRIPT_TEMPLATE = "import sys\ndef eval():\n\ttry:\n#initial\n\t\t#code\n#checker\n\texcept Exception as error:\n\t\treturn [type(error).__name__ + '-' + str(error),False]\nres = eval()\nsys.stdout.write(res[0] + '^' + str(res[1]))"

var tutorial_text = ""
var initial_code = ""
var checker = ""
var selected_random_index = 0

func _ready():
	randomize()
	
	selected_random_index = randi() % problem_list.size()
	var selected_problem = problem_list[selected_random_index]
	tutorial_text = selected_problem[0]
	initial_code = selected_problem[1]
	checker = selected_problem[2]
	
	tutorial.text = tutorial_text
	visible = false
	
func start():
	visible = true

func stop():
	visible = false

func _on_run_button_pressed():
	SoundMaster.play("menu_confirm")
	var result = evaluate_code(code_editor.text).split("^")
	print("test compiler: ",result)
	emit_signal("finish_problem",result[0], result[1] == 'True', selected_random_index)

func _on_reset_button_pressed():
	SoundMaster.play("menu_back")
	code_editor.text = ''
	pass

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

func _on_close_button_pressed():
	SoundMaster.play("menu_back")
	emit_signal("close")
