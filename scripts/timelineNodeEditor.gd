extends GraphEdit





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#    pass


func _on_GraphEdit_connection_request(from: String, from_slot: int, to: String, to_slot: int) -> void:
    connect_node(from, from_slot, to, to_slot)
