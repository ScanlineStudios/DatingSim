extends Control

var is_paused = false setget set_is_paused


func _ready() -> void:
    if Utility.game_manager.save_slot_location:
        $CenterContainer/VBoxContainer/SettingsBtn.show()
    else:
        $CenterContainer/VBoxContainer/SettingsBtn.hide()

func _unhandled_input(event):
    if event.is_action_pressed("paused"):
        self.is_paused = !is_paused


func set_is_paused(value):
    is_paused = value
    get_tree().paused = is_paused
    visible = is_paused


func _on_ResumeBtn_pressed():
    self.is_paused = false


func _on_QuitBtn_pressed():
    get_tree().quit()
