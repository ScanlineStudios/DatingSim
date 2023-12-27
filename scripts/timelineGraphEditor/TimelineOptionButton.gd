extends OptionButton


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    # Default value
    add_item("---")
    # Populate Items with dialogic timelines
    for timeline in DialogicUtil.get_sorted_timeline_list():
        add_item(timeline["name"])
        

        

