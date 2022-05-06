extends Node

# This script contains a bundle of functions that are usefull in 
# multiple places in the project.

#func get_random_point_in_CollisionShape2D(_shape: CollisionObject2D)->Vector2:
#	if _shape != 
#	return Vector2(0,0)

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
