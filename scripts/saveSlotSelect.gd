extends Control

var character_info_scene = "res://scenes/enterCharacterInfo.tscn"

func post_save_slot_selected():
	# Create save slot folder
	var dir = Directory.new()
	var err = dir.make_dir("user://userSaveData")
	if err:
		print_debug(err)
	err = dir.make_dir(Utility.save_location)
	if err:
		print_debug(err)
	get_tree().change_scene(character_info_scene)


func _on_Button1_pressed():
	Utility.save_location = "user://userSaveData/saveSlot1"
	post_save_slot_selected()
