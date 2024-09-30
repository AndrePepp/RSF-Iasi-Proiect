extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -700.0
const THINK_TIME = 0.1
const JUMP_THINK_TIME = 0.05

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 1600
var jumped = true

func _ready():
    $Timer.one_shot = true
    $JumpTimer.one_shot = true

func _physics_process(delta):
    # Add the gravity.
    if not is_on_floor():
        velocity.y += gravity * delta
    
    if(Input.is_action_just_pressed("jump") and not is_on_floor()):
        $Timer.start(THINK_TIME)
    
    # Handle jump.
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = JUMP_VELOCITY
        
    if $Timer.time_left > 0 and is_on_floor():
        velocity.y = JUMP_VELOCITY

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    var direction = Input.get_axis("move_left", "move_right")
    if direction:
        velocity.x = direction * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)

    move_and_slide()
