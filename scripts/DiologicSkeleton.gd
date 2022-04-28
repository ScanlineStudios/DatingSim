extends Node

# Attatches to DialogSkeleton node. Plays the Dialogic timeline
# given in the dialogicTimeline variable

export var dialogicTimeline = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	var dialog = Dialogic.start(dialogicTimeline)
	add_child(dialog)
	dialog.connect('dialogic_signal', self, '_on_dialogic_signal')
	
# TODO: move wait function to utilities class?
#func _wait(wait : int) -> void:
#	print_debug("waiting for ", wait)
#	var t = Timer.new()
#	t.set_wait_time(wait)
#	t.set_one_shot(true)
#	self.add_child(t)
#	t.start()
#	yield(t, "timeout")
#	t.queue_free()
	
	
func _on_dialogic_signal(value) -> void:
	SignalManager.emit_signal(value)
	

