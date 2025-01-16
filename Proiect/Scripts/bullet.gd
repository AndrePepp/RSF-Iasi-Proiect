extends Node2D

var gravity = 1600
var is_touching_ground = false
var player = null
var is_e_pressed = false

@onready var sprite = $RigidBody2D/Sprite2D
@onready var collision = $RigidBody2D/CollisionShape2D
@onready var area2d = $RigidBody2D/Area2D

func _ready():
 sprite.scale = Vector2(0.02, 0.02)
 area2d.scale = Vector2(15 * sprite.scale.x, 15 * sprite.scale.y)
 collision.scale = Vector2(95 * sprite.scale.x, 55 * sprite.scale.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if player:
        print(position)
        if Input.is_action_just_pressed("Interact") and player.e.is_colliding:
            is_e_pressed = !is_e_pressed
    
    if is_e_pressed:
        position = player.position + Vector2(20, -20)


func _on_area_2d_body_entered(body):
   if body.has_method("player"):
    player = body
    player.e.is_colliding = true
    
    

func _on_area_2d_body_exited(body):
 if body.has_method("player"):
     player = body
     player.e.is_colliding = false
