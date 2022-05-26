extends Node2D

onready var load_test_label: Label = get_node("MarginContainer/VBoxContainer/HBoxContainer/Label")
var FILE_NAME: String = Utility.save_slot_location+"/character_info.json"


func _ready():
	print_debug(FILE_NAME)
	var data: Dictionary = Utility.load_json(FILE_NAME)
	var label_text: String = ""
	
	for k in data:
		label_text+= k+": "+data[k]+"\n"
		
	load_test_label.text = label_text
