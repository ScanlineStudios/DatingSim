extends GraphEdit

export var new_timeline_node_menu: PackedScene
export var new_timeline_node: PackedScene
export var new_operator_node: PackedScene = null

onready var start_graph_node = get_node("StartNode")
onready var end_graph_node = get_node("EndNode")

const REQ_FOR_SLOT: int = 0
const PRE_REQ_SLOT: int = 0
const START_NODE_NAME: String = "StartNode"
const END_NODE_NAME: String = "EndNode"

# Timelein node graph datastructure
var timeline_nodes: Dictionary = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    # TODO: check error?
    var error = SignalManager.connect("new_timeline_node_confirm_buton_pressed", self, "_on_new_timeline_node_confirm_buton_pressed")
    error = SignalManager.connect("timeline_graph_editor_save_selected", self, "_on_timeline_graph_editor_save_selected")
    error = SignalManager.connect("timeline_graph_editor_load_selected", self, "_on_timeline_graph_editor_load_selected")
    error = SignalManager.connect("timeline_graph_editor_new_operator_selected", self, "_on_timeline_graph_editor_new_operator_selected")


    var start_node: GameManager.TimelineNode = Utility.game_manager.TimelineNode.new()
    start_node.timeline_name = start_graph_node.name
    var end_node: GameManager.TimelineNode = Utility.game_manager.TimelineNode.new()
    end_node.timeline_name = end_graph_node.name
    timeline_nodes[start_node.timeline_name] = start_node
    timeline_nodes[end_node.timeline_name] = end_node
    
    
func generate_end_node() -> BasicGraphNode:
    var new_timeline_node_instance: BasicGraphNode = new_timeline_node.instance()
    new_timeline_node_instance.name = END_NODE_NAME
    new_timeline_node_instance.set_slot_enabled_right(REQ_FOR_SLOT, false)
    new_timeline_node_instance.set_timeline(END_NODE_NAME)

    return new_timeline_node_instance


func generate_start_node() -> BasicGraphNode:
    var new_timeline_node_instance: BasicGraphNode = new_timeline_node.instance()
    new_timeline_node_instance.name = START_NODE_NAME
    new_timeline_node_instance.set_slot_enabled_left(PRE_REQ_SLOT, false)
    new_timeline_node_instance.set_timeline(START_NODE_NAME)

    return new_timeline_node_instance


func _on_ButtonNewNode_pressed() -> void:
    # Open a menu with fields to fill in for timeline node
    add_child(new_timeline_node_menu.instance())


func _on_GraphEdit_connection_request(from: String, from_slot: int, to: String, to_slot: int) -> void:
    connect_node(from, from_slot, to, to_slot)
    # update prereq lists
    timeline_nodes[from].req_for.append(to)
    timeline_nodes[to].pre_reqs.append(from)


func _on_GraphEdit_disconnection_request(from: String, from_slot: int, to: String, to_slot: int) -> void:
    if get_node(from).selected:
        disconnect_node(from, from_slot, to, to_slot)
        timeline_nodes[from].req_for.erase(to)
        timeline_nodes[to].pre_reqs.erase(from)


func _on_new_timeline_node_confirm_buton_pressed(timeline: String, location: String, character: String):
    var new_timeline_node_instance: TimelineGraphNode = new_timeline_node.instance() 
    add_child(new_timeline_node_instance)

    new_timeline_node_instance.title = timeline
    new_timeline_node_instance.name = timeline
    new_timeline_node_instance.set_timeline(timeline)
    new_timeline_node_instance.set_location(location)
    new_timeline_node_instance.set_character(character)
    new_timeline_node_instance.show_close = true
    
    var timeline_node: GameManager.TimelineNode = Utility.game_manager.TimelineNode.new()
    timeline_node.timeline_name = timeline
    timeline_node.location = location
    timeline_node.character = character
    
    timeline_nodes[timeline] = timeline_node

func _on_timeline_graph_editor_new_operator_selected(operation: int):
    var op_str: String = LogicGraphNode.Operation.keys()[operation]
    
    # create an new logic node with unique id and op_str as title
    var new_operator_node_instance: LogicGraphNode = new_operator_node.instance()
    
    
func _on_timeline_graph_editor_load_selected() -> void:
    # file explorer popup?
    var _dict: Dictionary = Utility.load_json("res://gameData/timelineDataTest.json")
    
    #print_debug(_dict)
    
    # remove all children
    for child in get_children():

        if child is GraphNode:
            child.queue_free()
    
    # Repopulate start and end node
    var _start: TimelineGraphNode = generate_start_node()
    var _end: TimelineGraphNode = generate_end_node()
    # add timeline nodes to data structure
    
    # connect nodes in data structure
    
    # add nodes to graph edit. position based on connections
    
func _on_timeline_graph_editor_save_selected() -> void:
    var dict_to_save: Dictionary = {}
    for timeline_name in timeline_nodes:
        var timeline_node: GameManager.TimelineNode = timeline_nodes[timeline_name]
        dict_to_save[timeline_name] = timeline_node.to_dict()

    Utility.save_dict_as_json("res://gameData/timelineDataTest.json", dict_to_save)
