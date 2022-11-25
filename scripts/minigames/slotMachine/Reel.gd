extends Node2D

# Reel represents the spinning part of a slot machine. 

# Takes a list of 5 images representing the faces that can align for a jackpot

export var spin_speed: float = 1
export var acceleration: float = 1
export var face_size_pixles: float = 100
export(PackedScene) var face_scene = preload("res://scenes/minigames/slotMachine/Face.tscn")

# Speed face will travel up
var current_speed: float
var acceleration_state: int
var displacement: float
var faces = []
var first_face
var last_face
var index = 0
var spinning: bool = false
enum accelerationMode{
    DECELERATE = -1,
    NONE = 0,
    ACCELERATE = 1
   }


# Called when the node enters the scene tree for the first time.
func _ready():
    current_speed = 0
    displacement = 0
    acceleration_state = accelerationMode.NONE
    
    #spawn faces
    for i in range(5):
        var instance = face_scene.instance()
        instance.scale.x = face_size_pixles / instance.texture.get_width()
        instance.scale.y = face_size_pixles / instance.texture.get_height()
        instance.position.y += i * face_size_pixles
        faces.append(instance)
        add_child(instance)
        
    first_face = faces[0]
    last_face = faces[faces.size()-1]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    current_speed += acceleration * acceleration_state * delta
    displacement += current_speed
    
    for face in faces:
        face.move_local_y(-current_speed)
    
    if(displacement > face_size_pixles):
        # move top face to bottem
        #first_face.position.y = last_face.position.y + displacement 
        first_face.position.y = last_face.position.y  + displacement
        displacement = 0
        last_face = first_face
        index += 1
        first_face = faces[index % faces.size()]
        



func _on_buttonStart_pressed():
    # accelerate for 2 seconds then stop accelerating
    if (!spinning && acceleration_state == accelerationMode.NONE):
        spinning = true
        acceleration_state = accelerationMode.ACCELERATE
        yield(get_tree().create_timer(2.0), "timeout")
        acceleration_state = accelerationMode.NONE
        


func _on_buttonStop_pressed():
    if (spinning && acceleration_state == accelerationMode.NONE):
        spinning = false
        acceleration_state = accelerationMode.DECELERATE
        yield(get_tree().create_timer(2.0), "timeout")
        acceleration_state = accelerationMode.NONE
        current_speed = 0
