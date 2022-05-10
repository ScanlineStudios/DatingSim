extends Node2D

# This script manages the dialog minigame interactions and the trasitions between the two.

#onready var freeze: Node = get_parent().get_node("Freeze")
onready var dialog: CanvasLayer = get_parent().get_node("DialogSkeleton")
onready var game: Node2D = get_child(0)

onready var misc_timer: Timer = Timer.new()

func get_all_nodes(node: Node) -> Array:
	var return_array = []
	for N in node.get_children():
		return_array.append_array([N])
		if N.get_child_count() > 0:
			return_array.append_array(get_all_nodes(N))
		
	# if no children return empty array
	return return_array


func _ready():
	
	add_child(misc_timer)
	
	Utility.freeze_scene(game, true)
	toggle_offspring_visible(game)
	var error = SignalManager.connect("tamerin_minigame_started", self, "_on_tamerin_minigame_started")
	if error:
		print("Error: ", error)
		
	error = SignalManager.connect("tamerin_minigame_ended",self, "_on_tamerin_minigame_ended")
	Utility.freeze_scene(game, true)
	Utility.freeze_scene(dialog, false)


func _on_tamerin_minigame_ended(score:int):
	# set score where dialogic can read it
	print_debug(score)
	Dialogic.set_variable("tamarin_score", score)
	
	Utility.freeze_scene(dialog, false)
	Dialogic.next_event()
	misc_timer.start(2)
	yield(misc_timer, "timeout")
	Utility.freeze_scene(game, true)
	# TODO: delay for fade out and unload minigame scene
	toggle_offspring_visible(game)


func _on_tamerin_minigame_started():
	# hide/show scenes and script generated nodes
	toggle_offspring_visible(game)
	
	Utility.freeze_scene(dialog, true)
	#TODO: move /hide dialog scene
	
	Utility.freeze_scene(game, false)
	
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
