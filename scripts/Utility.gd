extends Node

# This script contains a bundle of functions that are usefull in 
# multiple places in the project.

func freeze_node(node, freeze):
	node.set_process(!freeze)
	node.set_physics_process(!freeze)
	node.set_process_input(!freeze)
	node.set_process_internal(!freeze)
	node.set_process_unhandled_input(!freeze)
	node.set_process_unhandled_key_input(!freeze)

func freeze_scene(node, freeze):
	freeze_node(node, freeze)
	for c in node.get_children():
		freeze_scene(c, freeze)


func get_distance_between_vectors(vector_a :Vector2, vector_b: Vector2) -> float:
 var v = Vector2( vector_b - vector_a )
 return sqrt( (v.x * v.x) + (v.y * v.y) )

func get_random_point_in_area(shapeNode: CollisionShape2D)-> Vector2:
	var center = shapeNode.position
	var bounds = shapeNode.shape.extents
	
	var x_min = center.x - bounds.x
	var x_range_size = bounds.x*2
	var x_rand = rand_range(x_min, x_min+x_range_size) 
	
	var y_min = center.y - bounds.y
	var y_range_size = bounds.y*2
	var y_rand = rand_range(y_min, y_min+y_range_size)
	
	return Vector2(x_rand,y_rand)
