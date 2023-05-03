extends CanvasLayer

signal finish_dialogue()

export(String,FILE, "*.json") var dialogue_file
onready var name_label = $background/name
onready var text_label = $background/text

var dialogues = []
var current_dialogue_index = 0
var total_dialogue_index = 0

func _ready():
	visible = false
	dialogues = load_dialogue(dialogue_file)
	
	if (!dialogues or len(dialogues) == 0):
		print('empty dialogues')
		return
	
func _input(event):
	if visible and event.is_action_pressed("next_dialogue"):
		next_dialogue()
	
func load_dialogue(resource):
	var file = File.new()
	if file.file_exists(resource):
		file.open(resource,file.READ)
		return parse_json(file.get_as_text())

func start():
	
	
	current_dialogue_index = 0
	total_dialogue_index = len(dialogues)
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
	print('close dialogue')
	visible = false
	emit_signal("finish_dialogue")

func open_dialogue():
	visible = true
	start()


