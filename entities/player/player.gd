extends KinematicBody2D

signal player_interact()

onready var animation_player = $animation_player
onready var sprite = $sprite

export var move_speed = 10

var velocity = Vector2()
var moving = velocity.normalized().length() != 0
var facing_direction = velocity.normalized()

func _ready():
	pass

func _input(event):
	if (event.is_action_pressed("interact")):
		interact()

func _physics_process(delta):
	var input_vector = Vector2(float(Input.is_action_pressed("move_right")) - float(Input.is_action_pressed("move_left")), float(Input.is_action_pressed("move_down")) - float(Input.is_action_pressed("move_up")))
	velocity = input_vector * move_speed
	
	update_animation(input_vector)
	velocity = move_and_slide(velocity)
	
func update_animation(input_vector):
	
	var moving = input_vector.length() != 0 and is_physics_processing()
	
	if (input_vector.normalized() == Vector2.DOWN):
		facing_direction = Vector2.DOWN
	elif (input_vector.normalized() == Vector2.UP):
		facing_direction = Vector2.UP
	elif (input_vector.normalized() == Vector2.RIGHT):
		facing_direction = Vector2.RIGHT
	elif (input_vector.normalized() == Vector2.LEFT):
		facing_direction = Vector2.LEFT
	
	if (facing_direction == Vector2.DOWN):
		sprite.scale.x = 1
		animation_player.play("walk_down" if moving else "idle_down")
	elif (facing_direction == Vector2.UP):
		sprite.scale.x = 1
		animation_player.play("walk_up" if moving else "idle_up")
	elif (facing_direction == Vector2.RIGHT):
		sprite.scale.x = 1
		animation_player.play("walk_side" if moving else "idle_side")
	elif (facing_direction == Vector2.LEFT):
		sprite.scale.x = -1
		animation_player.play("walk_side" if moving else "idle_side")

func freeze():
	set_physics_process(false)
	update_animation(facing_direction)
	
func unfreeze():
	set_physics_process(true)
	update_animation(facing_direction)
	
func interact():
	emit_signal("player_interact")


