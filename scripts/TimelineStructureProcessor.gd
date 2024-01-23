extends Node

class_name TimelineStructureProcessor

var timeline_structure: Dictionary = {}

var complete_timeline_names: Array = []
var pending_timeline_names: Array = []
var locked_timeline_names: Array = []

func _init(timeline_structure_json: String = "") -> void:
    pass



func complete_pending(timeline_name: String)->void:
    # mark a pending timeline as complete. update status of timeline in structure
    pass
    

