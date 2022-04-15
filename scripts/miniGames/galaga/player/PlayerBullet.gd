extends "res://scripts/miniGames/actorBaseClassKine.gd"

#var explosion = preload("res://scenes/miniGames/galaga/Explosion0.tscn")

func _ready():
	# TODO: start self destruct timer
	# TODO: Orient in given direction?
	pass 


func _physics_process(delta):
	var collision = move_and_collide(-transform.y * move_speed * delta)



func _on_Hitbox_area_entered(_area):
	# DEBUG
	# print_debug(area.get_groups()[0])
	var explosion_instance = explosion.instance()
	explosion_instance.position = get_global_position()
	get_tree().get_root().add_child(explosion_instance)
	queue_free()
