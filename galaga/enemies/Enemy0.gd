extends KinematicBody2D

var move_speed = 250
var move_direction = Vector2.RIGHT


func _physics_process(delta):
	var collision = move_and_collide(move_direction * delta * move_speed)
	if collision:
		
		if collision.get_collider().is_in_group("wall"):
			move_direction = move_direction * -1 # .reflect(collision.normal)
			move_and_collide(Vector2.DOWN * delta * move_speed * 10)

