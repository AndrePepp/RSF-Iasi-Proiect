extends Area2D

var player = null  


func _process(_delta):
    if player:
        player.has_boost = true
        await get_tree().create_timer(0.1).timeout
        self.queue_free()

func _on_body_entered(body):
    if body.has_method("player"):
        player = body
