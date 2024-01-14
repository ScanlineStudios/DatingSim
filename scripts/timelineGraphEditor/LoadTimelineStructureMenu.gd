extends Control


onready var timeline_structure_data_option_button: OptionButton = get_node("CenterContainer/MarginContainer/VBoxContainer/HBoxContainer2/TimelineStructureDataOptionButton")

func _on_ButtonCancel_pressed() -> void:
    queue_free()


func _on_ButtonConfirm_pressed() -> void:
    var selected_text: String = timeline_structure_data_option_button.get_item_text(timeline_structure_data_option_button.selected)
    if "---" != selected_text:
        SignalManager.emit_signal("load_timeline_structure_as_confirm_button_pressed", selected_text)
        queue_free()
