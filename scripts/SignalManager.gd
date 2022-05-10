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




