extends Node2D

var currentY
@onready var main = get_tree().get_root().get_node("Game")
@onready var key_sample: PackedScene = load("res://Inventory/Regular items/ItemNodes/key_collectable.tscn")
@onready var animation = $Animation
var k = 0
var player = null
# Called when the node enters the scene tree for the first time.
func _ready():
    currentY = position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    if player:
        if Input.is_action_just_pressed("Interact") and player.e.is_colliding:
            slots()



func _on_area_2d_body_entered(body):
   if body.has_method("player"):
    player = body
    player.e.is_colliding = true


func _on_area_2d_body_exited(body):
    if body.has_method("player"):
     player = body
     player.e.is_colliding = false
    
func slots():
    if k == 0:
        animation.play("0->1")
    elif k == 1:
        animation.play("1->2")
    elif k == 2:
        animation.play("2->3")
    elif k == 3:
       var key = key_sample.instantiate()
       key.position = position + Vector2(0, -100)
       main.add_child(key)
    k+=1
