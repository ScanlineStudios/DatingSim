extends Node2D

onready var player_ship: KinematicBody2D = get_node("TamerinMinigameShip")

#onready var spawner = get_node("Spawner")
onready var enenmy0: PackedScene = preload("res://scenes/minigames/tamerinMinigame/enemies/Enemy0-1.tscn")
onready var squad: PackedScene = preload("res://scenes/minigames/tamerinMinigame/enemies/EnemySquad.tscn")
#other enemies here

onready var score_label: Label = get_node("GUI/MarginContainer/HBoxContainer/VBoxContainer/Score") 
onready var countdown_timer_label: Label = get_node("GUI/MarginContainer3/HBoxContainer2/VBoxContainer/CenterLabel")
onready var game_timer_label: Label = get_node("GUI/MarginContainer2/HBoxContainer2/VBoxContainer/GameTimer")

onready var countdown_tick_timer: Timer = Timer.new()
onready var spawn_timer: Timer = Timer.new()
onready var misc_timer: Timer = Timer.new()

onready var spawn_area: CollisionShape2D = get_node("SpawnArea/Shape")
onready var despawn_area: CollisionShape2D = get_node("DespawnArea/Shape")
onready var active_area: CollisionShape2D = get_node("ActiveArea/Shape")


var started: bool = false
var time_passed: float = 0.0
var time_remaining
var game_duration_seconds: int
var done_spawning = false

var SECONDS_IN_MIN = 60
var MINUTES_IN_HOUR = 60

# called after ending triger (player death, time out, all enemies dead)
func end(end_cause: String = "GAME OVER") -> void:
	
	var enemies = get_tree().get_nodes_in_group("enemy_ship")
	
	started = false
	
	update_center_label(end_cause)
	
	var score = score_label.score
	
	misc_timer.start(2)
	yield(misc_timer,"timeout")
	
	SignalManager.emit_signal("tamerin_minigame_ended", score)
	Utility.freeze_node(self, true)

func _on_tamerin_minigame_player_destroyed():
	end()

func on_actor_exited():
	# wait for destroyed node to be removed
	misc_timer.start(.5)
	yield(misc_timer, "timeout")
	
	if done_spawning:
		print_debug("Spawning finished")
	
	var enemies = get_tree().get_nodes_in_group("enemy_ship")
	var enemies_remaining = len(enemies)
	
	if done_spawning && enemies_remaining <= 0 && started:
		end("Level \nCleared!")
		

func _process(delta):
	
	# Game timer logic
	if started:
		time_passed += delta
		time_remaining = game_duration_seconds - time_passed
	
		var game_timer_seconds = int(fmod(time_remaining, SECONDS_IN_MIN))
		var game_timer_minuites = int(fmod(time_remaining, SECONDS_IN_MIN * MINUTES_IN_HOUR) / MINUTES_IN_HOUR)
		
		var game_timer_seconds_string = String(game_timer_seconds)
		var game_timer_minuites_string = String(game_timer_minuites)
		
		if game_timer_seconds < 10:
			game_timer_seconds_string = "0"+game_timer_seconds_string
		
		if game_timer_minuites < 10:
			game_timer_minuites_string = "0"+game_timer_minuites_string
			
		update_game_timer_label(game_timer_minuites_string+":"+game_timer_seconds_string)
	
		if int(time_remaining) == 0:
			end("TIME UP")


# Spawns a given number of given squads 
# TODO: add time active, after which they go off screen and despawn
func spawn_squads(_spawn_scene: PackedScene, num_to_spawn: int = 1, spawn_cooldown: int = 2, seconds_active: int = 30, squad_size: int = 5) -> void:
	# spawn num_to_spawn, waiting spawn_cooldown seconds after each spawn
	
	for _i in range(num_to_spawn):
		var spawn := _spawn_scene.instance() as KinematicBody2D
		
		# pick random point in spawn area
		var spawn_point: Vector2 = Utility.get_random_point_in_area(spawn_area)
		
		# Move the new instance to the Spawner2D position
		spawn.global_position = spawn_point# global_position
		# Face enemy downward
		spawn.global_rotation_degrees = global_rotation_degrees
		
		# pass allong active area and despawn area and seconds active
		spawn.set("active_area", active_area)
		spawn.set("despawn_area", despawn_area)
		spawn.set("seconds_active", seconds_active)
		spawn.set("target", player_ship)
		spawn.set("squad_size", squad_size)
		add_child(spawn)

		# Prevents the Spawner2D transform from affecting the new instance
		spawn.set_as_toplevel(true)

		# cooldown 
		spawn_timer.start(spawn_cooldown)
		yield(spawn_timer,"timeout")
		
	# TODO: change if waves become a thing
	done_spawning = true


# begine countdown then start spawning and rest of minigame. 
# TODO: potential dificulty input, timer input?
func start(_game_duration_seconds: int = 100, dificulty: int = 3) -> void:
	
	game_duration_seconds = _game_duration_seconds
	var squad_active_seconds = game_duration_seconds / 3
	# Countdown from 3, replace 0 with GO!
	# TODO reduce amount of magic numbers
	for num in range(3,-1, -1):
		countdown_tick_timer.start(1)
		var label_text : String = String(num)
		if (num == 0):
			label_text = "GO!"
		yield(countdown_tick_timer, "timeout")
		update_center_label(label_text)
		
	started = true
	
	spawn_squads(squad, dificulty, 2 ,squad_active_seconds,dificulty)
	
	# clear center label
	countdown_tick_timer.start(2)
	yield(countdown_tick_timer, "timeout")
	update_center_label("")


# Initialize tamerinMinigame but do not start spawning
func _ready():
	
	add_child(countdown_tick_timer)
	add_child(spawn_timer)
	add_child(misc_timer)
	
	var _error = SignalManager.connect("tamerin_minigame_player_destroyed", self, "_on_tamerin_minigame_player_destroyed")
	
	# todo: Configure squads?
	squad.set("spawn_scene", enenmy0)
	
	# do test sequence if this node is the root
	if (get_tree().get_root() == self.get_parent()):
		start(30,2) 


func update_center_label(update_string: String = "") -> void:
	countdown_timer_label.text = update_string


func update_game_timer_label(update_string: String = "") -> void:
	game_timer_label.text = update_string


