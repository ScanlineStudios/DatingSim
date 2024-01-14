extends OptionButton




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    add_item("---")
    # add files in 
    var dir = Directory.new()
    if dir.open(Utility.game_manager.TL_STRUCTURE_DATA_LOCATION) == OK:
        dir.list_dir_begin()
        var file_name = dir.get_next()
        while file_name != "":
            if dir.current_is_dir():
                # TODO: Go into dir
                pass
            else:
                add_item(file_name)
            file_name = dir.get_next()
    else:
        printerr("An error occured when trying to access load location.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#    pass
