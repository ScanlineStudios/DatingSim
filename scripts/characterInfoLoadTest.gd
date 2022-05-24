extends Node2D

onready var load_test_label: Label = get_node("MarginContainer/VBoxContainer/HBoxContainer/Label")
var FILE_NAME: String = Utility.save_slot_location+"/character_info.json"

## Returns dict of data in given file. Returns null on error or file not found
#func load_json(file_path: String):
#	var file = File.new()
#	if file.file_exists(file_path):
#		file.open(file_path, File.READ)
#		var data = parse_json(file.get_as_text())
#		file.close()
#		if typeof(data) == TYPE_DICTIONARY:
#			return data
#		else:
#			printerr("Corrupted data!")
#
#	else:
#		printerr("No saved data!")
#
#	return null


func _ready():
	print_debug(FILE_NAME)
	var data: Dictionary = Utility.load_json(FILE_NAME)
	var label_text: String = ""
	
	for k in data:
		label_text+= k+": "+data[k]+"\n"
		
	load_test_label.text = label_text
