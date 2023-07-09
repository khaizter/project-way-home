extends CanvasLayer

onready var question_title = $control/title
onready var question = $control/question
onready var choice_a = $control/choice_a
onready var choice_b = $control/choice_b
onready var choice_c = $control/choice_c
onready var score_label = $control/score_label

var question_data

var score = 0

var current_question_index = 0

var correct_answer_index = 0

var rand_generate = RandomNumberGenerator.new()

func _ready():
	rand_generate.randomize()
	question_data = read_json_file("questions/question-list.json")
	start_question()

func _process(delta):
	score_label.text = "Score: " + str(score)

func read_json_file(filename):
	var file = File.new()
	file.open(filename, file.READ)
	var text = file.get_as_text()
	var json_data = parse_json(text)
	file.close()
	return json_data

func start_question():
	current_question_index = 0
	randomize_question(current_question_index)


func next_question():
	current_question_index += 1
	randomize_question(current_question_index)

func randomize_question(index):
	var selected_question = question_data[index][rand_generate.randi_range(0,2)]
	var title = "Question " + str(index + 1) + "/10"
	var question = selected_question['question']
	var options = selected_question['options']
	var correct_option_index = selected_question['correct_option_index']
	load_question(title, question, options, correct_option_index)

func load_question(title, _question, options, correct_index):
	question_title.text = title
	question.text = _question
	choice_a.text = options[0]
	choice_b.text = options[1]
	choice_c.text = options[2]
	correct_answer_index = correct_index


func _on_choice_a_pressed():
	if correct_answer_index == 0:
		score += 1
	next_question()

func _on_choice_b_pressed():
	if correct_answer_index == 1:
		score += 1
	next_question()

func _on_choice_c_pressed():
	if correct_answer_index == 2:
		score += 1
	next_question()
