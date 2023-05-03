extends Area2D

onready var dialogue = $dialogue

var interacting = false

func _ready():
	pass

func _on_npc_body_entered(body):
	body.connect("player_interact",self,"interaction")

func interaction():
	if (not interacting):
		interacting = true
		print('npc begin interact')
		dialogue.open_dialogue()
		
		


func _on_npc_body_exited(body):
	body.disconnect("player_interact",self,"interaction")


func _on_dialogue_finish_dialogue():
	interacting = false
