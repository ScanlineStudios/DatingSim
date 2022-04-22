extends Node2D

onready var spawner = get_node("Spawner")
onready var enenmy0 = preload("res://scenes/minigames/tamerinMinigame/enemies/Enemy0-1.tscn")
onready var squad = preload("res://scenes/minigames/tamerinMinigame/enemies/EnemySquad.tscn")
#other enemies here


# Initialize tamerinMinigame but do not start spawning
func _ready():
	# do test sequence if this node is the root
	
	
	# todo: Configure squads?
	
	if (get_tree().get_root() == self.get_parent()):
		start() 


# begine countdown then start spawning and rest of minigame. 
# TODO: potential dificulty input?
func start():
	spawner.spawn_squads(squad, 7, 3)
