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
	player.connect("player_move",self, "_on_player_move")

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

func reset_position():
	global_position = initial_position

func move_to(direction,tween):
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
		tween.tween_property(self,"global_position",target_position,0.5)
		return true
	else:
		return false

func iterate_commands(commands):
	for index in range(len(commands)):
		var direction = commands[index]
		var tween = create_tween()
		if move_to(direction,tween):
			yield(tween, "finished")
		else:
#			illegal action
			pass
#		last command ended
		if index == len(commands) - 1:
			reset_position()

func run_code(code):
	evaluate_code(code)
#
	iterate_commands(commands)
	commands = []

func evaluate_code(input):
	var transformedInput  = input.replace('\n','\n\t') + '\n\tpass'
	var script = GDScript.new()
	script.set_source_code("func eval():\n\t" + transformedInput)
	script.reload()

	var obj = Reference.new()
	obj.set_script(script)

	print('code run')
	obj.eval() 

func _on_player_move(direction, times):
	for i in range(times):
		commands.append(direction)
