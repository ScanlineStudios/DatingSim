extends CanvasLayer

# Attatches to DialogSkeleton node. Plays the Dialogic timeline
# given in the dialogicTimeline variable

export var intro_timeline: String = "BarIntro"
export var default_timeline: String = "BarDefault"
export var location_name: String = "bar"
# Called when the node enters the scene tree for the first time.
func _ready():
    var dialog = Dialogic.start(default_timeline)
    if !Utility.game_manager.location_visit_counter.has(location_name):
        dialog = Dialogic.start(intro_timeline)

    # Utility.game_manager.increment_location_visit(location_name)
    add_child(dialog)
    dialog.connect('dialogic_signal', self, '_on_dialogic_signal')
    
    
func _on_dialogic_signal(value) -> void:
    SignalManager.emit_signal(value)
    
