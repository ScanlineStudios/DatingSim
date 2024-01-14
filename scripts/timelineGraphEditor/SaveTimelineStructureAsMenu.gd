extends Control


onready var save_location_label: Label = get_node("CenterContainer/MarginContainer/VBoxContainer/HBoxContainer2/Label")
onready var structure_name_line_edit: LineEdit = get_node("CenterContainer/MarginContainer/VBoxContainer/HBoxContainer2/LineEdit")
onready var input_hbox: HBoxContainer = get_node("CenterContainer/MarginContainer/VBoxContainer/HBoxContainer2")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    save_location_label.text = Utility.game_manager.TL_STRUCTURE_DATA_LOCATION



func _on_ButtonCancel_pressed() -> void:
    queue_free()


func _on_ButtonConfirm_pressed() -> void:
    if "" != structure_name_line_edit.text:
        SignalManager.emit_signal("save_timeline_structure_as_confirm_button_pressed", structure_name_line_edit.text)
        queue_free()
    else:
        # Highlight to text box
        input_hbox.modulate(Color(0xff8989))
