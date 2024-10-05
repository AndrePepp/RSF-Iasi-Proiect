extends Node2D

@onready var animation = $Sprite2D
var is_colliding: bool = false
var has_key: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
   visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    player_near()

func player_near():
   if is_colliding:
    visible = true
   elif not is_colliding :
    visible = false

    if Input.is_action_just_pressed("Interact") and is_colliding:
        animation.play("pressed")
        
   
