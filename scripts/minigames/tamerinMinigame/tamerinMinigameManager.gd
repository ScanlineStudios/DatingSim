extends Node2D

onready var spawner = get_node("Spawner")
onready var enenmy0 = preload("res://scenes/minigames/tamerinMinigame/enemies/Enemy0-1.tscn")
onready var squad = preload("res://scenes/minigames/tamerinMinigame/enemies/EnemySquad.tscn")
#other enemies here

onready var score_label: Label = get_node("GUI/MarginContainer/HBoxContainer/VBoxContainer/Score") 
onready var countdown_timer_label: Label = get_node("GUI/MarginContainer3/HBoxContainer2/VBoxContainer/CenterLabel")
onready var countdown_tick_timer: Timer = Timer.new()
onready var game_timer_label: Label = get_node("GUI/MarginContainer2/HBoxContainer2/VBoxContainer/GameTimer")

onready var spawn_area: CollisionObject2D = get_node("StaticBody2D/SpawnArea")
onready var despawn_area: CollisionObject2D = get_node("StaticBody2D/DespawnArea")

var started: bool = false
var time_passed: float = 0.0
var time_remaining
var duration_seconds: int


var SECONDS_IN_MIN = 60
var MINUTES_IN_HOUR = 60

# called after ending triger (player death, time out, all enemies dead)
func end(end_cause: String = "GAME OVER"):
	
	started = false
	
	update_center_label(end_cause)
	
	var score = score_label.score
	SignalManager.emit_signal("tamerin_minigame_ended", score)





func _on_tamerin_minigame_player_destroyed():
	end()


func _process(delta):
	
	# Game timer logic
	if started:
		time_passed += delta
		time_remaining = duration_seconds - time_passed
	
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


# begine countdown then start spawning and rest of minigame. 
# TODO: potential dificulty input, timer input?
func start(_duration_seconds: int = 100, dificulty: int = 50) -> void:
	
	duration_seconds = _duration_seconds
	# Countdown timer
	# TODO reduce amount of magic numbers
	# var seconds_to_countdown : int = 4 
	for num in range(3,-1, -1):
		countdown_tick_timer.start(1)
		var label_text : String = String(num)
		if (num == 0):
			label_text = "GO!"
		yield(countdown_tick_timer, "timeout")
		update_center_label(label_text)
		
	started = true
	
	spawner.spawn_squads(squad, 7, 3)
	
	# clear center label
	countdown_tick_timer.start(2)
	yield(countdown_tick_timer, "timeout")
	update_center_label("")
	

# Initialize tamerinMinigame but do not start spawning
func _ready():
	
	add_child(countdown_tick_timer) #to process
	var _error = SignalManager.connect("tamerin_minigame_player_destroyed", self, "_on_tamerin_minigame_player_destroyed")
	
	# todo: Configure squads?
	
	# do test sequence if this node is the root
	if (get_tree().get_root() == self.get_parent()):
		start() 


func update_center_label(update_string: String = "") -> void:
	countdown_timer_label.text = update_string


func update_game_timer_label(update_string: String = "") -> void:
	game_timer_label.text = update_string


