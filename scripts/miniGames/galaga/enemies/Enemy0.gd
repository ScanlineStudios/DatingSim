extends "res://scripts/miniGames/actorBaseClassKine.gd"


var move_direction = Vector2.RIGHT


func _ready():
	# lock rotation
	# set_mode(MODE_CHARACTER)
	# start movement routine
	# apply_central_impulse(DOWN * move_speed * .1)
	pass

func _physics_process(delta):
	pass
	# var collision = move_and_collide(DOWN * move_speed * .1 * delta)
	#if collision:
	#	print("Collided with: ", collision.collider.name)
	
#	for i in get_slide_count():
#		var c = get_slide_collision(i)
#		print("Collided with: ", c.collider.name)
#		_hit(c.get_groups()[0])

#		if collision.get_collider().is_in_group("wall"):
#			move_direction = move_direction * -1 # .reflect(collision.normal)
#			move_and_collide(Vector2.DOWN * delta * move_speed * 10)

func _on_Hurtbox_area_entered(area):
	_hit(area.get_groups()[0])
