extends Node2D

var obsticleNode

# Called when the node enters the scene tree for the first time.
func _ready():
    obsticleNode = get_node("/root/Game/Obsticle")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    player_near()

func player_near():
   if obsticleNode.is_colliding == true:
    visible = true
   else:
    visible = false
   
