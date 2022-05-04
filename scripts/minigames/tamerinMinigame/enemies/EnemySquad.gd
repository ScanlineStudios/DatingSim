extends "res://scripts/minigames/actorBaseClassKine.gd"

## This script handels the movement and spawning of individual enemy ships
export var ships_in_squad = 5
export var rotate_speed = 0
export var ship_dist_from_center = 40

export var spawn_scene: PackedScene

var active_area: CollisionShape2D
var despawn_area: CollisionShape2D
var seconds_active: int
var spawn_area: CollisionShape2D
# location squad is currently trying to move to
var location_to_move: Vector2

var random = RandomNumberGenerator.new()

onready var destination_refresh_timer: Timer = Timer.new()

func _physics_process(delta):
	
	# TODO: move twards target lovation
	var move_direction = position.direction_to(location_to_move)
	var collision = move_and_collide(move_direction * move_speed * .1 * delta)
	if collision:
		print("Collided with: ", collision.collider.name)


# TODO: squad movement pattern. Random-ish place in front of player to shoot.
#		Back and forth? 

# Called when the node enters the scene tree for the first time.
func _ready():
	# spawn ships_in_squad ships
	add_child(destination_refresh_timer)
	radial_spawn(ships_in_squad, ship_dist_from_center)
	location_to_move_picking_routine(target)


# Generate a list of coordinates starting at (0, dist_from_center) rotating 
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


# spawn ships in a radial patern
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
		

# while squad is active pick location infront of target
func location_to_move_picking_routine(target: KinematicBody2D) -> void:
	# TODO get
	var i = 0
	while target:
		
		var min_x = active_area.position.x - active_area.shape.extents.x
		var max_x = active_area.position.x + active_area.shape.extents.x
		
		var target_x = target.position.x
		var destination_x = random.randfn( target_x, 30)
		
		if destination_x > max_x:
			destination_x = max_x
		elif destination_x < min_x:
			destination_x = min_x
		
		var min_y = active_area.position.y - active_area.shape.extents.y
		var max_y = active_area.position.y + active_area.shape.extents.y
		var destination_y = rand_range(min_y, max_y)
		
		location_to_move = Vector2(destination_x, destination_y)
		print_debug("New move location: ", location_to_move)
		# wait 10 sec
		var delay = randi()%4
		destination_refresh_timer.start(5+delay)
		yield(destination_refresh_timer, "timeout")
		print_debug("Destination timer up", i)
	
