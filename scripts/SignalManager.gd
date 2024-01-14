# Event bus for distant nodes to communicate using signals.
# This is intended for cases where connecting the nodes directly creates more coupling
# or increases code complexity substantially.
extends Node

# Emitted to start Tamerin mini-game
signal tamerin_minigame_started
# Emitted when Tamerin mini-game player destroyed
signal tamerin_minigame_player_destroyed
# Emitted when Tamerin mini-game is finished. expect a score parameter
signal tamerin_minigame_ended(score)

# Emited when confirm button pressed in NewTimelineNodeMenu
signal new_timeline_node_confirm_buton_pressed(timeline_name, location, character)

signal timeline_graph_editor_save_selected
signal timeline_graph_editor_save_as_selected
signal timeline_graph_editor_load_selected
signal timeline_graph_editor_new_graph_selected

signal timeline_graph_editor_new_operator_selected(operator)

signal save_timeline_structure_as_confirm_button_pressed(structure_name)
signal load_timeline_structure_as_confirm_button_pressed(structure_name)
