extends Node2D


# TODO: Options/settings data
#       Save/ load player data
#       Objectives?
export var initial_scene: PackedScene = null

var active_scene: PackedScene = null
var player_location: String = ""
var active_node: Node = null
var active_timeline: String = ""
var save_slot_location: String = ""
var location_visit_counter: Dictionary = {}
var dialog: CanvasLayer = null
var active_dialog_node =  null
var map_enabled: bool = false
var timelines_complete: Array = []

# Key: timeline_name (String)
# Value: TimelineNode
var timeline_nodes: Dictionary = {}

class TimelineNode:
    var id: int 
    var timeline_name: String
    var location: String
    var characters: Array
    var pre_reqs: Array
    var req_for: Array 

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_map"):
        toggle_map()

func _on_active_node_tree_exited(node: Node) -> void:
    if node == active_node:
        active_node = null


func _on_dialogic_signal(value) -> void:
    SignalManager.emit_signal(value)


# Called when the node enters the scene tree for the first time.
func _ready():
    # add initial active scene as a child of this node
    set_active_node(initial_scene.instance())
    read_timeline_data()


func change_player_location(new_location: String) -> void:
    if new_location != player_location:
        increment_location_visit(new_location)
        player_location = new_location
        print_debug("Player location: ", player_location)


func change_timeline(new_timeline: String) -> void:
    if !dialog:
        print_debug("No Dialogic node active. Use start_dialogic().")
        return
    if Dialogic.timeline_exists(new_timeline):
        Dialogic.change_timeline(new_timeline)
        active_timeline = new_timeline


func enable_map() -> void:
    map_enabled = true


# todo: go to function for each location?
func go_to_bar()-> void:
    change_player_location("bar")
    if !timelines_complete.has("BarIntro"):
        # play opening bar sequence timeline if it hasnt been completed
        start_dialogic("BarIntro")
        
    else:
        # Default bar options
        start_dialogic("BarDefault")
        

func go_to_diner() -> void:
    change_player_location("diner")
    if !timelines_complete.has("DinerIntro"):
        start_dialogic("DinerIntro")
    else:
        start_dialogic("DinerDefault")
        
        
func go_to_garage() -> void:
    change_player_location("garage")
    # Slate is busy until all location intros complete
    if !(timelines_complete.has("BarIntro") &&
        timelines_complete.has("DinerIntro")):
        start_dialogic("SlateBusy")
    else:
        start_dialogic("GarageDefault")


func hide_map() -> void:
    $map.hide()


func increment_location_visit(location: String) -> void:
    if location_visit_counter.has(location):
        location_visit_counter[location] += 1
    else:
        location_visit_counter[location] = 1


# return status code?
func load_data() -> void:
    # load data from player save data location into variables
    pass


func save_data() -> void:
    # save variable data to player save data location  
    pass
    

func show_map() -> void:
    if map_enabled:
        $map.show()
    else:
        print_debug("Map not avalible")


func set_active_node(node: Node) -> void:
    if active_node:
        remove_child(active_node)
        active_node = null
    node.connect("tree_exited", self, "_on_active_node_tree_exited", [node])
    active_node = node
    add_child(node)


func toggle_map():
    if $map.visible:
        hide_map()
    else:
        show_map()


func start_dialogic(timeline: String) -> void:
    if !Dialogic.timeline_exists(timeline):
        print_debug("Timeline with name: ", timeline, " does not exist.")
        return
        
    dialog = Dialogic.start(timeline)
    active_timeline = timeline

    dialog.connect('dialogic_signal', self, '_on_dialogic_signal')
    set_active_node(dialog)
    
    
func read_timeline_data() -> void:
    var read_data: Dictionary = Utility.load_json("res://gameData/timelineData.json")
    for obj in read_data:
        var new_timeline_node: TimelineNode = TimelineNode.new()
        new_timeline_node.characters = read_data[obj]["characters"]
        new_timeline_node.timeline_name = read_data[obj]["timeline_name"]
        new_timeline_node.id = read_data[obj]["id"]
        new_timeline_node.location = read_data[obj]["location"]
        timeline_nodes[new_timeline_node.timeline_name] = new_timeline_node
        
    
    for obj in read_data:
        var timeline_name = read_data[obj]["timeline_name"]
        # Conect pre reqs
        for pre_reqs in read_data[obj]["pre_reqs"]:
            

            timeline_nodes[timeline_name].pre_reqs.append(timeline_nodes[pre_reqs])
        # conect req fors
        for req_for in read_data[obj]["req_for"]:

            timeline_nodes[timeline_name].req_for.append(timeline_nodes[req_for])
                
    
    print_debug(timeline_nodes)
    
func unload_active_scene() -> void:
    if active_node:
        remove_child(active_node)
        active_node = null


# add active timeline to list of complete timelines
func timeline_complete() -> void:
    if !timelines_complete.has(active_timeline):
        timelines_complete.append(active_timeline)



