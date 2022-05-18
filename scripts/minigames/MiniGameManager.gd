extends Node2D

# This script manages the dialog minigame interactions and the trasitions between the two.

onready var dialog: CanvasLayer = get_parent().get_node("DialogSkeleton")
onready var game: Node2D = get_child(0)

onready var misc_timer: Timer = Timer.new()


func _ready():
	
	add_child(misc_timer)
	
	Utility.freeze_scene(game, true)
	Utility.toggle_offspring_visible(game)
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
	# delay for fade out and unload minigame scene
	misc_timer.start(2)
	yield(misc_timer, "timeout")
	Utility.freeze_scene(game, true) 
	Utility.toggle_offspring_visible(game)


func _on_tamerin_minigame_started():
	# hide/show scenes and script generated nodes
	Utility.toggle_offspring_visible(game)
	
	Utility.freeze_scene(dialog, true)
	#TODO: move /hide dialog scene
	
	Utility.freeze_scene(game, false)
	
	game.start(30)

