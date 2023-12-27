extends Resource

class_name TimelineNodeDataFactory

const timeline_node_data = preload("res://scripts/timelineGraphEditor/TimelineNodeData.gd")
const timeline_node_timeline_data = preload("res://scripts/timelineGraphEditor/TimelineNodeTimelineData.gd")

static func get_timeline_node_data_properties() -> Array:
    var new_timeline_node_data: TimelineNodeData = timeline_node_data.new()
    var prop_dicts =  new_timeline_node_data.get_property_list()
    var _array = []
    
    for prop in prop_dicts:
        if TimelineNodeData.excluded_properties.find(prop.name) == -1:
            _array.append(prop.name)
    
    return _array 

static func get_timeline_node_timeline_data_properties() -> Array:
    var new_timeline_node_timeline_data: TimelineNodeTimelineData = timeline_node_timeline_data.new()
    var prop_dicts =  new_timeline_node_timeline_data.get_property_list()
    var _array = []
    
    for prop in prop_dicts:
        if TimelineNodeData.excluded_properties.find(prop.name) == -1:
            _array.append(prop.name)
    
    return _array

static func create_tl_node_data(_id: int) -> TimelineNodeData:
    var new_timeline_node_data: TimelineNodeData = timeline_node_data.new()
    new_timeline_node_data.id = _id
    return new_timeline_node_data
    

static func create_tl_node_tl_data(_id: int, _tl_name: String, _character: String, _location: String) -> TimelineNodeTimelineData:
    var new_timeline_node_timeline_data: TimelineNodeTimelineData = timeline_node_timeline_data.new()
    new_timeline_node_timeline_data.id = _id
    new_timeline_node_timeline_data.timeline_name = _tl_name
    new_timeline_node_timeline_data.character = _character
    
    return new_timeline_node_timeline_data

static func from_dict(_dict: Dictionary):
    var data_node_to_return = null
    
    if _dict.has_all(get_timeline_node_timeline_data_properties()):
        data_node_to_return = timeline_node_timeline_data.new()

    elif _dict.has_all(get_timeline_node_data_properties()):
        data_node_to_return = timeline_node_data.new()

    else:
        printerr("Unknown node data")
        return null

    for key in _dict.keys():
        data_node_to_return[key] = str2var(_dict[key])
    return data_node_to_return

static func match_exclued_properties(property: String) -> bool:
    return TimelineNodeData.excluded_properties.has(property)
