extends "res://scripts/miniGames/actorBaseClassKine.gd"

#var explosion = preload("res://scenes/miniGames/galaga/Explosion0.tscn")

func _ready():
	# TODO: start movement routine?
	# TODO: start self destruct timer
	pass 


func _physics_process(delta):
	move_and_collide(FORWARD * move_speed * delta)


func _on_Hitbox_area_entered(area):
	# if !body.is_in_group("player"):
	# DEBUG
	print(area.get_groups()[0])
	var explosion_instance = explosion.instance()
	explosion_instance.position = get_global_position()
	get_tree().get_root().add_child(explosion_instance)
	queue_free()
