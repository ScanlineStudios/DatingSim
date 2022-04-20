extends "res://scripts/minigames/actorBaseClassKine.gd"

## This script handels the movement and spawning of individual enemy ships
export var ships_in_squad = 5
export var rotate_speed = 0
export var ship_dist_from_center = 40

export var spawn_scene: PackedScene

# TODO: Grid or radial spawn pattern?

# TODO: squad movement pattern. Random-ish place in front of player to shoot.
#		Back and forth? 

# Called when the node enters the scene tree for the first time.
func _ready():
	# spawn ships_in_squad ships
	radial_spawn(ships_in_squad, ship_dist_from_center)
	


# TODO: move squad back and fourth 
func _physics_process(delta):
	
	var collision = move_and_collide(RIGHT * move_speed * .1 * delta)
	if collision:
		print("Collided with: ", collision.collider.name)

# TODO: Generate a list of coordinates starting at (0, dist_from_center) rotating 
# clockwise 
func radial_coordinates_to_spawn(num_to_spawn : int, dist_from_center: int) -> Array:
	var increment0 = 2*PI/num_to_spawn # int division be carful
	var increment1 = PI/num_to_spawn
	
	var coordinates : Array = []
	for i in range(num_to_spawn):
		var x = dist_from_center * cos(increment0*i + increment1)
		var y = dist_from_center * sin(increment0*i + increment1)
		coordinates.append(Vector2(x,y))
	
	return coordinates

# TODO: spawn ships in a radial patern
func radial_spawn(num_to_spawn : int, dist_from_center: int):
	# find coordinates to spawn ships at
	var coordinates = radial_coordinates_to_spawn(num_to_spawn, dist_from_center)
	for coordinate in coordinates: 
		var spawn := spawn_scene.instance() as Node2D
		#spawn.global_position += coordinate
		# point enemy down
		#spawn.global_rotation_degrees = global_rotation_degrees
		add_child(spawn)
		#spawn.set_as_toplevel(true)
		
	
