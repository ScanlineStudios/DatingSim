extends Node2D

export var bar_scene: PackedScene = null


func _on_BarBtn_pressed() -> void:
    Utility.game_manager.change_active_scene(bar_scene)
