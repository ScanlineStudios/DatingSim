extends "res://scripts/miniGames/actorBaseClassKine.gd"

## This script handels the movement and spawning of individual enemy ships
export var ships_in_squad = 0
export var squad_speed = 200
export var rotate_speed = 0
export var ship_dist_from_center = 40

export var spawn_scene: PackedScene

# TODO: Grid or radial spawn pattern?

# Called when the node enters the scene tree for the first time.
func _ready():
	# TODO: spawn ships_in_squad ships
	var spawn := spawn_scene.instance() as Node2D
	add_child(spawn)
	#spawn.set_as_toplevel(true)
	spawn.global_position = global_position


# TODO: move squad back and fourth against the screen 
func _physics_process(delta):
	
	var collision = move_and_collide(RIGHT * move_speed * .1 * delta)
	if collision:
		print("Collided with: ", collision.collider.name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
