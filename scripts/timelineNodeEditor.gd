extends GraphEdit

export var new_timeline_node_menu: PackedScene
export var new_timeline_node: PackedScene



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    var error = SignalManager.connect("new_timeline_node_confirm_buton_pressed", self, "_on_new_timeline_node_confirm_buton_pressed")

    
    
func _unhandled_input(event: InputEvent) -> void:
    # New node on right click?
    pass


func _on_GraphEdit_connection_request(from: String, from_slot: int, to: String, to_slot: int) -> void:
    connect_node(from, from_slot, to, to_slot)


func _on_GraphEdit_disconnection_request(from: String, from_slot: int, to: String, to_slot: int) -> void:
    if get_node(from).selected:
        disconnect_node(from, from_slot, to, to_slot)


func _on_new_timeline_node_confirm_buton_pressed(timeline: String, location: String, character: String):
    var new_timeline_node_instance: TimelineGraphNode = new_timeline_node.instance() 
    new_timeline_node_instance.title = timeline
    add_child(new_timeline_node_instance)


func _on_ButtonNewNode_pressed() -> void:
    # Open a menu with fields to fill in for timeline node
    add_child(new_timeline_node_menu.instance())
    pass # Replace with function body.
