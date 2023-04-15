extends KinematicBody2D


onready var right_checker = $right_checker
onready var left_checker = $left_checker
onready var down_checker = $down_checker
onready var up_checker = $up_checker

export var speed = 90

var cell_size = 16

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
#	var input_vector := Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
#	var move_direction := input_vector.normalized()
#	move_and_slide(speed * move_direction)


	pass
	
func _input(event):
	var target_position = global_position
	if event.is_action_pressed("move_right"):
		move_to(Vector2.RIGHT)
	if event.is_action_pressed("move_left"):
		move_to(Vector2.LEFT)
	if event.is_action_pressed("move_down"):
		move_to(Vector2.DOWN)
	if event.is_action_pressed("move_up"):
		move_to(Vector2.UP)

func move_to(direction):
	var target_position = global_position + (direction * cell_size)
	var can_move = false
	if (direction == Vector2.RIGHT and len(right_checker.get_overlapping_bodies()) == 0):
		can_move = true
	if (direction == Vector2.LEFT and len(left_checker.get_overlapping_bodies()) == 0):
		can_move = true
	if (direction == Vector2.DOWN and len(down_checker.get_overlapping_bodies()) == 0):
		can_move = true
	if (direction == Vector2.UP and len(up_checker.get_overlapping_bodies()) == 0):
		can_move = true
	if can_move:
		self.position = target_position
	else:
		return

	
	
	
	


	
