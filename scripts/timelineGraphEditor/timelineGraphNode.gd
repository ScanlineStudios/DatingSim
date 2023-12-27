extends BasicGraphNode

class_name TimelineGraphNode

onready var location_label = get_node("VBoxContainer/HBoxContainer/LabelLocation")
onready var character_label = get_node("VBoxContainer/HBoxContainer2/LabelCharacter")



#
#func _on_TimelineGraphNode_focus_entered() -> void:
#    selected = true
#    # open window to edit fields
#
#
#func _on_TimelineGraphNode_focus_exited() -> void:
#    selected = false
#    # close window to edit fields
#

func set_character(character: String) -> void:
    character_label.text = character

    
func set_location(location: String) -> void:
    location_label.text = location
    
    
func set_timeline(timeline: String) -> void:
    title = timeline
