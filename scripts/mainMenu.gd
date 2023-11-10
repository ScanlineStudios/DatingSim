extends Node2D

export var test_scene: PackedScene
export var save_slot_scene: PackedScene

# TODO: Continue functionality

func _on_buttonStart_pressed():
    Utility.game_manager.change_active_scene(test_scene)


func _on_buttonNew_pressed():
    Utility.game_manager.change_active_scene(save_slot_scene)
