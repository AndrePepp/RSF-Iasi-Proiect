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
            open()



func _on_area_2d_body_entered(body):
   if body.has_method("player"):
    player = body
    player.e.is_colliding = true


func _on_area_2d_body_exited(body):
    if body.has_method("player"):
     player = body
     player.e.is_colliding = false
    
func open():
    if player.e.has_key:
        get_tree().change_scene_to_file("res://Scenes/level_2.tscn")
