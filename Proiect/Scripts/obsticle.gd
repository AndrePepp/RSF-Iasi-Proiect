extends Node2D

var currentY
var player = null
# Called when the node enters the scene tree for the first time.
func _ready():
    currentY = position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    if player:
        if Input.is_action_just_pressed("Interact") and player.e.is_colliding:
            await get_tree().create_timer(0.1).timeout
            queue_free()



func _on_area_2d_body_entered(body):
   if body.has_method("player"):
    player = body
    player.e.is_colliding = true


func _on_area_2d_body_exited(body):
    if body.has_method("player"):
     player = body
     player.e.is_colliding = false
    
