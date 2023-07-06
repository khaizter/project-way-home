extends Area2D

export var level:PackedScene

onready var interact_button = $interact_button
onready var key = $interact_button/key
onready var lock = $interact_button/lock
onready var sprite = $sprite
onready var open_indicator = $open_indicator

export var variant = 0

var player_in_range = false

var open = false

func _ready():
	interact_button.visible = false
	open_indicator.visible = false
	key.visible = false
	sprite.frame = variant

func _process(delta):
	interact_button.visible = player_in_range
	open_indicator.visible = open if not interact_button.visible else false
	if open:
		key.visible = true
		lock.visible = false
	else:
		lock.visible = true
		key.visible = false

func enter():
	if (open):
		print("go next")
		if (level):
			get_tree().change_scene_to(level)
	else :
		Notification.show_notification("Complete the task first")
		print("complete first")

func _on_door_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		body.connect("player_interact",self,"enter")


func _on_door_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		body.disconnect("player_interact",self,"enter")
