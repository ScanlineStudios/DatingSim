extends Node

# Attatches to DialogSkeleton node. Plays the Dialogic timeline
# given in the dialogicTimeline variable

export var dialogicTimeline = ""

# Called when the node enters the scene tree for the first time.
func _ready():
    var dialog = Dialogic.start(dialogicTimeline)
    add_child(dialog)
    dialog.connect('dialogic_signal', self, '_on_dialogic_signal')
    
    
func _on_dialogic_signal(value) -> void:
    SignalManager.emit_signal(value)
    

