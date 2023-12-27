extends Resource

class_name TimelineNodeData

var id: int
var inputs: Array
var outputs: Array

const excluded_properties: Array = ["excluded_properties", "Reference", "script", "Script Variables", "Resource", "resource_local_to_scene","resource_name", "resource_path",  ]

func print():
    for i in self.get_property_list():
        if excluded_properties.find(i.name) == -1:
            print(i.name, ": ", self[i.name])

func to_dict() -> Dictionary:
    var _dict: Dictionary = {}
    for i in self.get_property_list():
        if excluded_properties.find(i.name) == -1:
            _dict[i.name] = self[i.name]

    return _dict

