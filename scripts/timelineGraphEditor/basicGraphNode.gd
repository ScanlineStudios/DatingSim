extends GraphNode

class_name BasicGraphNode

export var pending_color: Color = Color(1, 1, 1, 1)
export var complete_color: Color = Color(.75, 1, .75, 1)
export var locked_color: Color = Color(1, .75, .75, 1)

var id: int

enum PreviewModeStates {PENDING, COMPLETE, LOCKED}

var preview_mode_state = PreviewModeStates.PENDING


func set_preview_mode_state(state: int) -> void:
    match state:
        PreviewModeStates.PENDING:
            modulate = pending_color
            preview_mode_state = PreviewModeStates.PENDING
            set_slot_color_right(0, pending_color)
            set_slot_color_left(0, pending_color)
        PreviewModeStates.COMPLETE:
            modulate = complete_color
            preview_mode_state = PreviewModeStates.COMPLETE
            set_slot_color_right(0, complete_color)
            set_slot_color_left(0, complete_color)
        PreviewModeStates.LOCKED:
            modulate = locked_color
            preview_mode_state = PreviewModeStates.LOCKED
            set_slot_color_right(0, locked_color)
            set_slot_color_left(0, locked_color)


func _on_TimelineGraphNode_focus_entered() -> void:
    selected = true
    # open window to edit fields


func _on_TimelineGraphNode_focus_exited() -> void:
    selected = false
    # close window to edit fields
    

