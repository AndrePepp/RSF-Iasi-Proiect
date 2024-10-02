extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -700.0
const THINK_TIME = 0.1
const JUMP_THINK_TIME = 0.05
const COYOTE_TIME = 0.13

var gravity = 1600
var jumped = true
var coyote_timer  
var can_jump = false
var coyote_timer_started = false
var is_jumping_animation = false
@onready var animations = $AnimatedSprite2D

func _ready():
    $Timer.one_shot = true
    $JumpTimer.one_shot = true
    coyote_timer = Timer.new()  # Create a new Timer
    add_child(coyote_timer)
    coyote_timer.one_shot = true

func _physics_process(delta):
    # Add the gravity.
    if (not is_on_floor()):
        velocity.y += gravity * delta

    if is_on_floor():
        can_jump = true
        coyote_timer_started = false
    elif not is_on_floor() and coyote_timer.time_left == 0 and not coyote_timer_started:
        coyote_timer.start(COYOTE_TIME)
        coyote_timer_started = true
            
    if coyote_timer.time_left == 0 and not is_on_floor():
        can_jump = false
        
    
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
    
    if direction > 0:
        animations.flip_h = false
    elif direction < 0:
        animations.flip_h = true
    
    if not animations.is_playing() and is_jumping_animation:
        is_jumping_animation = false
    
    if Input.is_action_just_pressed("jump"):
        animations.play("jump_start")
        is_jumping_animation = true
    elif not is_on_floor() and not is_jumping_animation:
        animations.play("jump_end")
    elif is_on_floor():
        if direction == 0:
            animations.play("idle")
            is_jumping_animation = false
        else:
            animations.play("running")
            is_jumping_animation = false

    
    if direction:
        velocity.x = direction * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)

    move_and_slide()
