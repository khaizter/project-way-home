extends CanvasLayer

signal hide()

export(String, MULTILINE) var text

onready var label = $control/label

func _ready():
	visible = false
	set_text(text)

func set_text(text):
	label.text = text

func show():
	visible = true

func hide():
	visible = false
	emit_signal('hide')

func _on_gotit_button_pressed():
	hide()
