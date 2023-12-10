extends GraphNode

class_name TimelineGraphNode

# Corosponding Timeline Node
var timelineNode = Utility.game_manager.TimelineNode.new() 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#    pass


func _on_TimelineGraphNode_focus_entered() -> void:
    selected = true
    # open window to edit fields


func _on_TimelineGraphNode_focus_exited() -> void:
    selected = false
    # close window to edit fields


func _on_TimelineGraphNode_slot_updated(idx: int) -> void:
    print_debug("Node", title, "port", idx, "updated" )
    
