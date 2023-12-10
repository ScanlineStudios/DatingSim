extends OptionButton


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    # Default value
    add_item("---")
    for character in DialogicUtil.get_sorted_character_list():
        add_item(character["name"])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#    pass
