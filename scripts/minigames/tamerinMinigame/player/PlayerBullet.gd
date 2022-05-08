extends "res://scripts/minigames/actorBaseClassKine.gd"

onready var self_destruct_timer: Timer = Timer.new()

#var explosion = preload("res://scenes/minigames/tamerinMinigame/Explosion0.tscn")

func _ready():
	# TODO: start self destruct timer
	add_child(self_destruct_timer)
	# TODO: Orient in given direction?
	self_destruct_timer.start(10)
	yield(self_destruct_timer, "timeout")
	queue_free() 


func _physics_process(delta):
	var _collision = move_and_collide(-transform.y * move_speed * delta)



func _on_Hitbox_area_entered(_area):
	# DEBUG
	# print_debug(area.get_groups()[0])
	var explosion_instance = explosion.instance()
	explosion_instance.position = get_global_position()
	get_tree().get_root().add_child(explosion_instance)
	queue_free()
