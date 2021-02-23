extends Position2D

export var spawn_scene: PackedScene
export var num_to_spawn: int
export var spawn_cooldown: float
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var thread

# Called when the node enters the scene tree for the first time.
func _ready():
	# Start spawn process
	thread = Thread.new()
	thread.start(self, "_spawn_tread",spawn_scene)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _spawn_tread(_spawn_scene := spawn_scene) -> void:
	# spawn num_to_spawn, waiting spawn_cooldown seconds after each spawn
	
	for i in range(num_to_spawn):
		var spawn := _spawn_scene.instance() as Node2D

		add_child(spawn)

		# Prevents the Spawner2D transform from affecting the new instance
		spawn.set_as_toplevel(true)

		# Move the new instance to the Spawner2D position
		spawn.global_position = global_position
		# cooldown 
		var t = Timer.new()
		t.set_wait_time(spawn_cooldown)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t,"timeout")
		
