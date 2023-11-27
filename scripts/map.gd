extends CanvasLayer

func _on_BarBtn_pressed() -> void:
    Utility.game_manager.go_to_bar()
    Utility.game_manager.hide_map()


func _on_DinerBtn_pressed() -> void:
    Utility.game_manager.go_to_diner()
    Utility.game_manager.hide_map()


func _on_GarageBtn_pressed() -> void:
    Utility.game_manager.go_to_garage()
    Utility.game_manager.hide_map()
