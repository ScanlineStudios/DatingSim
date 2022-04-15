extends Node2D

# This script is used to control wheather a scene is active or not. For example when a mini game 
# overlay come up during dialog the diolag scene will be set to inactive wile the plauer plays the 
# mini game then set back to active when the player is done   

var is_active = true setget set_is_active
#var timer = get_tree().create_timer(10.0)
onready var freeze = get_parent().get_node("Freeze")
onready var dialog = get_parent().get_node("DialogSkeleton")
onready var game = get_child(0)


func _ready():
	game.visible = false
	freeze.freeze_scene(game, true)
	game.hide()
	var error = SignalManager.connect("start_tamerin_minigame", self, "_on_start_tamerin_minigame")
	if error:
		print("Error: ", error)
	freeze.freeze_scene(game, true)
	freeze.freeze_scene(dialog, false)
	

#func _unhandled_input(event):
#	pass
	# TODO: set a buttion for toggling is_active for debugging?
	#if event.is_action_pressed("paused"):
	#	self.is_paused = !is_paused


func set_is_active(value):
	is_active = value
	# = !is_active
	print(str(name.replace("@", "").replace(str(int(name)), "")) + "Active: " + str(is_active))
	# TODO: impliment a visual indicator that corrosponds to is_active status
	# visible = is_active


func _on_start_tamerin_minigame():
	print("minigame signal recieved")
	
	game.show()
	
	### dialog.paused = true
	freeze.freeze_scene(dialog, true)
	dialog.hide()
	
	#yield( get_tree().create_timer(2.0), "timeout")
	#print("timer finished")
	
	freeze.freeze_scene(game, false)
