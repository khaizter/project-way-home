extends Area2D

export var level:PackedScene

onready var interact_button = $control/interact_button
var player_in_range = false

var open = false

func _ready():
	interact_button.visible = false

func _process(delta):
	interact_button.visible = player_in_range

func enter():
	if (open):
		print("go next")
		if (level):
			get_tree().change_scene_to(level)
	else :
		print("complete first")

func _on_door_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		body.connect("player_interact",self,"enter")


func _on_door_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		body.disconnect("player_interact",self,"enter")
