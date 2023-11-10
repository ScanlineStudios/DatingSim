extends Control

export var character_info_scene: PackedScene # "res://scenes/enterCharacterInfo.tscn"



func post_save_slot_selected():
    # Create save slot folder
    var dir = Directory.new()
    var err = dir.make_dir("user://userSaveData")
    if err:
        print_debug(err)
    err = dir.make_dir(Utility.game_manager.save_slot_location)
    if err:
        print_debug(err)
    Utility.game_manager.change_active_scene(character_info_scene)


func _on_Button1_pressed():
    Utility.game_manager.save_slot_location = "user://userSaveData/saveSlot1"
    post_save_slot_selected()


func _on_Button2_pressed():
    Utility.game_manager.save_slot_location = "user://userSaveData/saveSlot2"
    post_save_slot_selected()


func _on_Button3_pressed():
    Utility.game_manager.save_slot_location = "user://userSaveData/saveSlot3"
    post_save_slot_selected()

func _ready():
    var status_lables = {}
    status_lables["1"] = get_node("MarginContainer/VBoxContainer/Label")
    status_lables["2"] = get_node("MarginContainer/VBoxContainer/VBoxContainer2/Label2")
    status_lables["3"] = get_node("MarginContainer/VBoxContainer/VBoxContainer3/Label3")

    for k in status_lables:
        var try_load_path = "user://userSaveData/saveSlot"+k
        var character_data = Utility.load_json(try_load_path+"/character_info.json")
        if character_data:
            status_lables[k].text = ""
            for data_k in character_data:
                status_lables[k].text += data_k+": "+character_data[data_k]+"\n"
        else:
            status_lables[k].text = "Empty"
