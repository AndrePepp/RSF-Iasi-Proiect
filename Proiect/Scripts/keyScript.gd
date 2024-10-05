extends StaticBody2D

@export var item: InvItem
var player = null

func _ready():
    visible = true

func _on_area_2d_body_entered(body):
    if body.has_method("player"):
        print("+ key")
        player = body
        player.e.has_key = true
        await get_tree().create_timer(0.1).timeout
        self.queue_free()
    

    
