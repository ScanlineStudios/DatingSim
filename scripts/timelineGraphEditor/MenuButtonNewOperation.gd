extends MenuButton


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    for op_string in LogicGraphNode.Operation:
        # add operation to menu except for placeholder NONE operation
        var keys = LogicGraphNode.Operation.keys()
        if op_string != keys[LogicGraphNode.Operation.NONE]:
            get_popup().add_item(op_string, keys.find(op_string) )

    get_popup().connect("id_pressed", self, "_on_MenuButtonNewOperation_item_selected")


func _on_MenuButtonNewOperation_item_selected(id: int) -> void:
    print_debug(LogicGraphNode.Operation.keys()[id])

    SignalManager.emit_signal("timeline_graph_editor_new_operator_selected", id)
            
