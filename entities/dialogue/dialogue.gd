extends CanvasLayer

signal finish_dialogue(page)

onready var name_label = $control/name
onready var text_label = $control/text

var dialoguePages = []
var dialogues = []
var current_dialogue_index = 0
var total_dialogue_index = 0

var currentPage = 0

func _ready():
	visible = false

func start(page = 0,payload = {}):
	open_dialogue()
	currentPage = page
	dialogues = dialoguePages[page]
	
	if (!dialogues or len(dialogues) == 0):
		print('empty dialogues')
		return
	
	current_dialogue_index = 0
	total_dialogue_index = len(dialogues)
	
	# change dynamic values via payload
	dialogues = apply_dynamic_values(dialogues,payload)
	
	update_dialogue(current_dialogue_index)

func update_dialogue(index):
	name_label.text = dialogues[index]['name']
	text_label.text = dialogues[index]['text']

func next_dialogue():
	if(current_dialogue_index < total_dialogue_index - 1):
		current_dialogue_index += 1
		update_dialogue(current_dialogue_index)
	else:
		close_dialogue()
	
func close_dialogue():
	visible = false
	emit_signal("finish_dialogue",currentPage)

func open_dialogue():
	visible = true
	
func apply_dynamic_values(dialogues,payload):
	for quote in dialogues:
		for key in quote:
			var text = quote[key]
			for variable in payload:
				quote[key] = text.replace('(' + variable + ')', payload[variable])
	return dialogues

func initialize_dialogues(dialogue_files):
	for dialogue_file in dialogue_files:
		dialoguePages.append(load_dialogue(dialogue_file))
	
func load_dialogue(resource):
	var file = File.new()
	if file.file_exists(resource):
		file.open(resource,file.READ)
		return parse_json(file.get_as_text())

func _input(event):
	if visible and event.is_action_pressed("next_dialogue"):
		next_dialogue()


