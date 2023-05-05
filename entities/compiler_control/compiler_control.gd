extends Control

signal run_code(code)

export var player_nodepath : NodePath
onready var run_button = $run_button
onready var code_editor = $code_editor
onready var lecture_container = $lecture_container

var player = null

func _ready():
	if player_nodepath:
		player = get_node(player_nodepath)
	if player:
		self.connect("run_code",player,"run_code")
		pass

func _on_run_button_pressed():
	emit_signal("run_code",code_editor.text)

func _on_lecture_button_pressed():
	lecture_container.visible = false
