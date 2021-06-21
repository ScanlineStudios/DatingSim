extends Node2D

var galaga_scene = load("res://scenes/miniGames/galaga/galaga.tscn")

signal start_tamerin_minigame

# Called when the node enters the scene tree for the first time.
func _ready():
	var dialog = Dialogic.start("TamarinTest")
	add_child(dialog)
	dialog.connect('start_tamerin_minigame', self, '_on_DialogRoot_start_tamerin_minigame')
	
	
func _wait(wait : int) -> void:
	print_debug("waiting for ", wait)
	var t = Timer.new()
	t.set_wait_time(wait)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	
	
func _on_DialogRoot_start_tamerin_minigame() -> void:
	print_debug("starting minigame")
	var instance = galaga_scene.instance()
	add_child(instance)

