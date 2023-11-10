extends Button

func _on_buttonStart_pressed():
	Utility.game_manager.change_active_scene("res://scenes/testScenes/GameManagementTest.tscn")
