extends "res://scripts/miniGames/actorBaseClass.gd"


var move_direction = Vector2.RIGHT

func _ready():
	# lock rotation
	set_mode(MODE_CHARACTER)
	# start movement routine
	apply_central_impulse(DOWN * move_speed * .1)
	pass

func _physics_process(delta):
	 
	
	#var collision = move_and_collide(move_direction * delta * move_speed)
	#if collision:
#
#		if collision.get_collider().is_in_group("wall"):
#			move_direction = move_direction * -1 # .reflect(collision.normal)
#			move_and_collide(Vector2.DOWN * delta * move_speed * 10)
#
	pass 
