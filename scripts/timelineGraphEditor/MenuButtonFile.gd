extends MenuButton


func _ready() -> void:
    get_popup().connect("id_pressed", self, "_on_MenuButtonFile_item_selected")


func _on_MenuButtonFile_item_selected(id: int) -> void:
    match id:
        0:
            #print_debug("New Graph Selected")
            SignalManager.emit_signal("timeline_graph_editor_new_graph_selected")
        1:
            #print_debug("Save Selected")
            SignalManager.emit_signal("timeline_graph_editor_save_selected")
        2:
            #print_debug("Load Selected")
            SignalManager.emit_signal("timeline_graph_editor_load_selected")
