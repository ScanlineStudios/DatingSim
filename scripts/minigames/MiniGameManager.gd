extends Node2D

# This script is used to control wheather a scene is active or not. For example when a mini game 
# overlay come up during dialog the diolag scene will be set to inactive wile the plauer plays the 
# mini game then set back to active when the player is done   

#var is_active = true setget set_is_active
#var timer = get_tree().create_timer(10.0)
onready var freeze: Node = get_parent().get_node("Freeze")
onready var dialog: CanvasLayer = get_parent().get_node("DialogSkeleton")
onready var game: Node2D = get_child(0)


func get_all_nodes(node: Node) -> Array:
	var return_array = []
	for N in node.get_children():
		return_array.append_array([N])
		if N.get_child_count() > 0:
			return_array.append_array(get_all_nodes(N))
		
	# if no children return empty array
	return return_array


func _ready():
	
	freeze.freeze_scene(game, true)
	toggle_offspring_visible(game)
	var error = SignalManager.connect("tamerin_minigame_started", self, "_on_tamerin_minigame_started")
	if error:
		print("Error: ", error)
		
	error = SignalManager.connect("tamerin_minigame_ended",self, "_on_tamerin_minigame_ended")
	freeze.freeze_scene(game, true)
	freeze.freeze_scene(dialog, false)


func _on_tamerin_minigame_ended(score:int):
	# set score where dialogic can read it
	print_debug(score)
	Dialogic.set_variable("tamarin_score", score)
	freeze.freeze_scene(dialog, false)
	freeze.freeze_scene(game, true)
	# TODO: delay for fade out and unload minigame scene
	toggle_offspring_visible(game)


func _on_tamerin_minigame_started():
	# hide/show scenes and script generated nodes
	toggle_offspring_visible(game)
	
	freeze.freeze_scene(dialog, true)
	#TODO: move /hide dialog scene
	
	freeze.freeze_scene(game, false)
	
	game.start()

# TODO: Move to utility 
#func set_offspring_visible(node: Node, _visible:bool)-> void:
#	var all_decendant_nodes = get_all_nodes(self)
#	print_debug(all_decendant_nodes)
#	for node in all_decendant_nodes:
#		if node.get("visible") != null:
#			print("visible = "+String(_visible))
#			node.visible = _visible
	
func toggle_offspring_visible(node: Node)->void:
	var all_decendant_nodes = get_all_nodes(self)
	
	for node in all_decendant_nodes:
		if node.get("visible") != null:
			
			node.visible = !node.visible
