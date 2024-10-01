extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -700.0
const THINK_TIME = 0.1
const JUMP_THINK_TIME = 0.05
const COYOTE_TIME = 0.00001

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 1600
var jumped = true
var coyote_timer = null  
var can_jump = false

func _ready():
    $Timer.one_shot = true
    $JumpTimer.one_shot = true
    coyote_timer = Timer.new()  # Create a new Timer
    coyote_timer.one_shot = true
    coyote_timer.wait_time = COYOTE_TIME
    add_child(coyote_timer)

func _physics_process(delta):
    # Add the gravity.
    if (not is_on_floor()):
        velocity.y += gravity * delta

    if(is_on_floor()):
        can_jump = true
        coyote_timer.stop()  			# Stop the timer if on the floor
    else:								# Check if the coyote timer has finished
        if coyote_timer.is_stopped():
            coyote_timer.start()
    
    if Input.is_action_just_pressed("jump") and can_jump:
        velocity.y = JUMP_VELOCITY
        can_jump = false
    
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
