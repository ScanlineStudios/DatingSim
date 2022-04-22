extends Position2D

export var spawn_scene: PackedScene
#export var num_to_spawn: int
#export var spawn_cooldown: float


# Called when the node enters the scene tree for the first time.
func _ready():
	# spawn_squads(spawn_scene)
	pass


# Spawns a given number of given squads 
func spawn_squads(_spawn_scene := spawn_scene, num_to_spawn := 1, spawn_cooldown := 2) -> void:
	# spawn num_to_spawn, waiting spawn_cooldown seconds after each spawn
	
	for _i in range(num_to_spawn):
		var spawn := _spawn_scene.instance() as Node2D
		# Move the new instance to the Spawner2D position
		spawn.global_position = global_position
		# Face enemy downward
		spawn.global_rotation_degrees = global_rotation_degrees
		add_child(spawn)

		# Prevents the Spawner2D transform from affecting the new instance
		spawn.set_as_toplevel(true)

		
		# cooldown 
		var t = Timer.new()
		t.set_wait_time(spawn_cooldown)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t,"timeout")
		
