extends KinematicBody2D

onready var right_checker = $right_checker
onready var left_checker = $left_checker
onready var down_checker = $down_checker
onready var up_checker = $up_checker

var cell_size = 16

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
	for direction in commands:
		var tween = create_tween()
		if move_to(direction,tween):
			yield(tween, "finished")
			print('commanded')
		else:
			print('action cannot do')

func run_code(code):
	evaluate_code(code)
#	var commands = []
#	commands.append(Vector2.LEFT)
#	commands.append(Vector2.RIGHT)
#	commands.append(Vector2.RIGHT)
#	commands.append(Vector2.RIGHT)
#	commands.append(Vector2.DOWN)
#	iterate_commands(commands)

func evaluate_code(input):
	var transformedInput  = input.replace('\n','\n\t')
#	transformedInput = transformedInput.replace('print','print_output')
	var script = GDScript.new()
	script.set_source_code("func eval():\n\t" + transformedInput)
	script.reload()

	var obj = Reference.new()
	obj.set_script(script)

#	return obj.eval() 
	obj.eval() 
