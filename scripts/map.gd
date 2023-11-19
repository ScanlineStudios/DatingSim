extends CanvasLayer

export var bar_scene: PackedScene = null


func _on_BarBtn_pressed() -> void:
    Utility.game_manager.go_to_bar()
    Utility.game_manager.hide_map()
