extends Area2D

onready var dialogue = $dialogue
onready var interact_button = $control/interact_button

var interacting = false
var player = null
var player_in_range = false

func _ready():
	interact_button.visible = false

func _process(delta):
	interact_button.visible = player_in_range
	
func interaction():
	if (not interacting):
		interacting = true
		print('npc begin interact')
		player.set_physics_process(false)
		dialogue.open_dialogue()

func _on_npc_body_entered(body):	
	if body.is_in_group("player"):
		player = body
		player_in_range = true
		body.connect("player_interact",self,"interaction")
		
func _on_npc_body_exited(body):
	if body.is_in_group("player"):
		player = null
		player_in_range = false
		body.disconnect("player_interact",self,"interaction")


func _on_dialogue_finish_dialogue():
	interacting = false
	player.set_physics_process(true)
