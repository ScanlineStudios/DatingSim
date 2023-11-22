extends Node2D

export var test_scene: PackedScene
export var save_slot_scene: PackedScene

# TODO: Continue functionality




func _on_buttonNew_pressed():
    Utility.game_manager.set_active_node(save_slot_scene.instance())


func _on_buttonCharacterTest_pressed() -> void:
    Utility.game_manager.start_dialogic("CharacterTests")
