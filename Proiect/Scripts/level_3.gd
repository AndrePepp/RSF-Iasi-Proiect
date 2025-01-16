extends Node2D

func _process(delta):
    if Input.is_action_just_pressed("reset_level"):
        reset()
        
func reset():
    get_tree().change_scene_to_file("res://Scenes/level_3.tscn")
