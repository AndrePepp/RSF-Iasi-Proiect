extends Area2D

var player = null
var ok = false
@onready var timer = $Timer_Lv2

func _ready():
    timer.wait_time = 3
    timer.one_shot = true

func _process(_delta):
    if ok == true:
        player.level_2()

func _on_body_entered(body):
   if body.has_method("player"):
    player = body
    ok = true
    timer.start()


func _on_timer_lv_2_timeout():
    get_tree().change_scene_to_file("res://Scenes/level_3.tscn")
