extends CanvasLayer

onready var label = $background/label
onready var animation_player = $animation_player

func _ready():
	visible = false
	
func show_notification(text):
	if animation_player.current_animation != 'pop':
		label.text = text
		animation_player.play("pop")
	else:
		print('already notification')


func _on_animation_player_animation_started(anim_name):
	visible = true


func _on_animation_player_animation_finished(anim_name):
	visible = false
