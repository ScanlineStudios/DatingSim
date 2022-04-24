# Event bus for distant nodes to communicate using signals.
# This is intended for cases where connecting the nodes directly creates more coupling
# or increases code complexity substantially.
extends Node

# Emitted to start Tamerin mini-game
signal start_tamerin_minigame
# Emitted when Tamerin mini-game player destroyed
signal tamerin_minigame_player_destroyed
#
signal score_changed



