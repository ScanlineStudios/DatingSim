extends GraphNode

class_name BasicGraphNode

var id: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


func _on_TimelineGraphNode_focus_entered() -> void:
    selected = true
    # open window to edit fields


func _on_TimelineGraphNode_focus_exited() -> void:
    selected = false
    # close window to edit fields
    

