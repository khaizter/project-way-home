extends CanvasLayer

export var level_1_scene:PackedScene
export var level_2_scene:PackedScene
export var level_3_scene:PackedScene
export var level_4_scene:PackedScene
export var level_5_scene:PackedScene
export var level_6_scene:PackedScene
export var level_7_scene:PackedScene
export var level_8_scene:PackedScene

onready var main = $control/main
onready var stages = $control/stages
onready var level_1 = $"control/stages/level_1"
onready var level_2 = $"control/stages/level_2"
onready var level_3 = $"control/stages/level_3"
onready var level_4 = $"control/stages/level_4"
onready var level_5 = $"control/stages/level_5"
onready var level_6 = $"control/stages/level_6"
onready var level_7 = $"control/stages/level_7"
onready var level_8 = $"control/stages/level_8"


func _ready():
	init()

func init():
	level_1.disabled = not Player.is_level_unlocked("1")
	level_2.disabled = not Player.is_level_unlocked("2")
	level_3.disabled = not Player.is_level_unlocked("3")
	level_4.disabled = not Player.is_level_unlocked("4")
	level_5.disabled = not Player.is_level_unlocked("5")
	level_6.disabled = not Player.is_level_unlocked("6")
	level_7.disabled = not Player.is_level_unlocked("7")
	level_8.disabled = not Player.is_level_unlocked("8")
	main.visible = true
	stages.visible = false

func _on_start_button_pressed():
	SoundMaster.play("menu_confirm")
	main.visible = false
	stages.visible = true

func _on_exit_button_pressed():
	get_tree().quit()

func _on_back_pressed():
	SoundMaster.play("menu_back")
	main.visible = true
	stages.visible = false

func _on_level_1_pressed():
	SoundMaster.play("menu_confirm")
	if (level_1_scene):
		get_tree().change_scene_to(level_1_scene)

func _on_level_2_pressed():
	SoundMaster.play("menu_confirm")
	if (level_2_scene):
		get_tree().change_scene_to(level_2_scene)

func _on_level_3_pressed():
	SoundMaster.play("menu_confirm")
	if (level_3_scene):
		get_tree().change_scene_to(level_3_scene)

func _on_level_4_pressed():
	SoundMaster.play("menu_confirm")
	if (level_4_scene):
		get_tree().change_scene_to(level_4_scene)

func _on_level_5_pressed():
	SoundMaster.play("menu_confirm")
	if (level_5_scene):
		get_tree().change_scene_to(level_5_scene)


func _on_level_6_pressed():
	SoundMaster.play("menu_confirm")
	if (level_6_scene):
		get_tree().change_scene_to(level_6_scene)


func _on_level_7_pressed():
	SoundMaster.play("menu_confirm")
	if (level_7_scene):
		get_tree().change_scene_to(level_7_scene)


func _on_level_8_pressed():
	SoundMaster.play("menu_confirm")
	if (level_8_scene):
		get_tree().change_scene_to(level_8_scene)


func _on_reset_button_pressed():
	SoundMaster.play("menu_back")
	Player.reset_data()
	init()


func _on_credits_button_pressed():
	SoundMaster.play("menu_back")
	get_tree().change_scene("res://levels/end_credits/end_credits.tscn")

