extends Node2D

var currentY
var is_colliding
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	currentY = position.y
	is_colliding = false
	player = get_node("/root/Game/Player") as Area2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	


func _on_area_2d_area_entered(_area):
	is_colliding = true


func _on_area_2d_area_exited(_area):
	is_colliding = false
