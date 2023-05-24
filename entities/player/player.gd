extends KinematicBody2D

signal player_interact()

onready var right_checker = $right_checker
onready var left_checker = $left_checker
onready var down_checker = $down_checker
onready var up_checker = $up_checker

onready var initial_position = global_position
export var move_speed = 10
var cell_size = 16
var commands = []

var velocity = Vector2()

func _ready():
	pass

func _input(event):
	if (event.is_action_pressed("interact")):
		interact()
		pass

func _physics_process(delta):
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_down"):
		velocity.y += move_speed
	if Input.is_action_pressed("move_up"):
		velocity.y -= move_speed
	if Input.is_action_pressed("move_left"):
		velocity.x -= move_speed
	if Input.is_action_pressed("move_right"):
		velocity.x += move_speed
	
	move_and_slide(velocity)
	

func interact():
	emit_signal("player_interact")


