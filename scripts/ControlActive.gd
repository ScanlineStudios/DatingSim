extends Control

# This script is used to control wheather a scene is active or not. For example when a mini game 
# overlay come up during dialog the diolag scene will be set to inactive wile the plauer plays the 
# mini game then set back to active when the player is done   

var is_active = true setget set_is_active

func _unhandled_input(event):
	pass
	# TODO: set a buttion for toggling is_active for debugging?
	#if event.is_action_pressed("paused"):
	#	self.is_paused = !is_paused


func set_is_active(value):
	is_active = value
	 = !is_active
	print(str(name.replace("@", "").replace(str(int(name)), "")) + "Active: " + str(is_active))
	# TODO: impliment a visual indicator that corrosponds to is_active status
	# visible = is_active

