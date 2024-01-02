extends BasicGraphNode

class_name TimelineGraphNode

onready var location_label = get_node("VBoxContainer/HBoxContainer/LabelLocation")
onready var character_label = get_node("VBoxContainer/HBoxContainer2/LabelCharacter")



func get_class(): return "TimelineGraphNode"

func set_character(character: String) -> void:
    character_label.text = character

    
func set_location(location: String) -> void:
    location_label.text = location
    
    
func set_timeline(timeline: String) -> void:
    title = timeline
