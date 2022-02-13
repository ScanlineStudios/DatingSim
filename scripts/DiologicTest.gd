extends Node2D

var galaga_scene = load("res://scenes/miniGames/galaga/galaga.tscn")

signal start_tamerin_minigame

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child.has_method("set_is_active"):
			child.set_is_active(false)

	var dialog = Dialogic.start("TamarinTest")
	add_child(dialog)
	dialog.connect('start_tamerin_minigame', self, '_on_DialogRoot_start_tamerin_minigame')
	dialog.connect("signal",self,"signal_func")
	
func _wait(wait : int) -> void:
	print_debug("waiting for ", wait)
	var t = Timer.new()
	t.set_wait_time(wait)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	
	
func _on_DialogRoot_start_tamerin_minigame(value) -> void:
	print_debug("starting minigame")
	print_debug(value)
	var instance = galaga_scene.instance()
	add_child(instance)

func signal_func():
	print("signal")
