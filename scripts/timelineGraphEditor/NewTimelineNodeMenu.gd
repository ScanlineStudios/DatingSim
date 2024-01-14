extends Control

onready var timeline_option = get_node("CenterContainer/MarginContainer/VBoxContainer/HBoxContainer/TimelineOptionButton")
onready var location_line_edit = get_node("CenterContainer/MarginContainer/VBoxContainer/HBoxContainer2/LineEdit")
onready var character_option = get_node("CenterContainer/MarginContainer/VBoxContainer/HBoxContainer3/CharacterOptionButton")


func _on_ButtonCancel_pressed() -> void:
    queue_free()


func _on_ButtonConfirm_pressed() -> void:
    # confirm valid values for fields. 
    var timeline: String = timeline_option.get_item_text(timeline_option.selected)
    var location: String = location_line_edit.text
    var character: String = character_option.get_item_text(character_option.selected)
    if timeline != "---" and location != "" and character != "---":
        # Send signal to create new node with given data
        SignalManager.emit_signal("new_timeline_node_confirm_buton_pressed", timeline, location, character)
        # delete self
        queue_free()



