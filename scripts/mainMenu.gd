extends Node2D



func _on_buttonStart_pressed():
	get_tree().change_scene("res://scenes/testScenes/GameManagementTest.tscn")


func _on_buttonNew_pressed():
	get_tree().change_scene("res://scenes/saveSlotSelect.tscn")
