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
onready var active_timer: Timer = Timer.new()

# onready var location_to_move_picking_thread = Thread.new()


func despawn_routine()->void:
	active_timer.start(seconds_active)
	yield(active_timer, "timeout")
	
	# set target to null to stop movement routine
	target = null
	# set location_to_move to random location in despawn zone
	location_to_move = Utility.get_random_point_in_area(despawn_area)


func _physics_process(delta):
	
	# TODO: move twards target lovation
	var move_direction = position.direction_to(location_to_move)
	var collision = move_and_collide(move_direction * move_speed * .1 * delta)
	if collision:
		print("Collided with: ", collision.collider.name)


# Called when the node enters the scene tree for the first time.
func _ready():
	# add timers
	add_child(destination_refresh_timer)
	add_child(active_timer)
	
	# spawn ships_in_squad ships
	radial_spawn(ships_in_squad, ship_dist_from_center)
	
	location_to_move_picking_routine()
	
	#despawn squad after timer finished
	despawn_routine()
	


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
func location_to_move_picking_routine() -> void:
	
	while target:
		
		var min_x = active_area.position.x - active_area.shape.extents.x
		var max_x = active_area.position.x + active_area.shape.extents.x
		
		var target_x = target.position.x
		var destination_x = random.randfn( target_x, 50)
		
		
		destination_x = clamp(destination_x, min_x, max_x)
		
		
		var min_y = active_area.position.y - active_area.shape.extents.y
		var max_y = active_area.position.y + active_area.shape.extents.y
		var destination_y = rand_range(min_y, max_y)
		
		location_to_move = Vector2(destination_x, destination_y)
		#print_debug("New move location: ", location_to_move)
		# wait 10 sec
		var delay = randi()%4
		destination_refresh_timer.start(3+delay)
		yield(destination_refresh_timer, "timeout")
		#print_debug("Destination timer up", i)
	
