extends Node2D


# TODO: Options/settings data
#		
export var active_scene: PackedScene = null

var player_location: String = ""

var active_node: Node = null
var save_slot_location: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
    # add initial active scene as a child of this node
    change_active_scene(active_scene)

# TODO: return status code?
func change_active_scene(scene: PackedScene) -> void:
    if active_node:
        remove_child(active_node)
    if scene:
        var new_node: Node = scene.instance()
        active_node = new_node
        add_child(new_node)


func hide_map() -> void:
    $map.hide()

# TODO: location enum?
func set_player_location(loacation: String) -> void:
    player_location = loacation
    print_debug("Player location: ", player_location)

func show_map() -> void:
    $map.show()
