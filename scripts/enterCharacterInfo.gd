extends Control


onready var preview_label: Label = get_node("MarginContainer2/VBoxContainer/HBoxContainer/Label")
onready var preview_base_text: String = preview_label.text

onready var suit_color_rect: ColorRect = get_node("MarginContainer2/VBoxContainer/HBoxContainer2/MarginContainer/ColorRect") 

var character_info: Dictionary = {
	"character_name": "",
	"pronoun_subject": "",
	"pronoun_object": "",
	"pronoun_possesive": "",
	"suit_color": "" 
}

func get_new_label_text()->String:
	var label_text = preview_base_text 
	
	var underscore: String = "_"
	
	for k in character_info:
		var replace_string = character_info[k]
		
		if character_info[k] == "":
			replace_string = underscore
			
		label_text = label_text.replacen("<"+k+">", replace_string)
	
	return label_text
	
func _ready():
	
	var label_text = get_new_label_text()
	update_preview_label(label_text)
	
func update_preview_label(text: String):
	preview_label.text = text


func _on_LineEditName_text_changed(new_text):
	character_info.character_name = new_text
	
	var label_text = get_new_label_text()
	update_preview_label(label_text)


func _on_LineEditProSub_text_changed(new_text):
	character_info.pronoun_subject = new_text
	
	var label_text = get_new_label_text()
	update_preview_label(label_text)


func _on_LineEditProPos_text_changed(new_text):
	character_info.pronoun_possesive = new_text
	
	var label_text = get_new_label_text()
	update_preview_label(label_text)


func _on_LineEditProObj_text_changed(new_text):
	character_info.pronoun_object
	
	var label_text = get_new_label_text()
	update_preview_label(label_text)


func _on_ColorPickerSuit_color_changed(color):
	character_info.suit_color = color
	
	suit_color_rect.color = character_info.suit_color
