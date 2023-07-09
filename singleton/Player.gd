extends Node

signal player_move(direction, times)

const SAVE_FILE = 'res://save_data/save_file.save'
var initial_data = {
			"data_name": "Player",
			"levels" : {"1" : true, "2" : false, "3"  : false, "4" : false, "5" : false, "6" : false,"7" : false, "8" : false}
		}
var g_data = initial_data

func _ready():
	load_data()

func set_name(value):
	g_data["data_name"] = value
	save_data()
	
func get_name():
	return g_data["data_name"]
	
func unlock_level(value):
	g_data["levels"][value] = true
	save_data()

func is_level_unlocked(value):
	return g_data["levels"][value]


func save_data():
	var file = File.new()
	file.open(SAVE_FILE, file.WRITE)
	file.store_var(g_data)
	file.close()

func load_data():
	var file = File.new()
	if not file.file_exists(SAVE_FILE):
		g_data = initial_data
		save_data()
	file.open(SAVE_FILE, File.READ)
	g_data = file.get_var()
	file.close()

func reset_data():
	var file = File.new()
	g_data = initial_data
	save_data()
	file.open(SAVE_FILE, File.READ)
	g_data = file.get_var()
	file.close()
