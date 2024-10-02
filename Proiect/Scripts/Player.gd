extends CharacterBody2D


const SPEED = 350.0
const SHIFT_SPEED = 600.0
const JUMP_VELOCITY = -700.0
const THINK_TIME = 0.1
const JUMP_THINK_TIME = 0.05
const COYOTE_TIME = 0.13
const IDLE_COOLDOWN = 3

var gravity = 1600
var jumped = true
var acceleration = SPEED
var running_text = "running"
var coyote_timer  
var idle_timer
var is_idle = false
var can_jump = false
var idle_timer_started = false
var coyote_timer_started = false
var is_jumping_animation = false
var is_animation_choosed = false
@onready var animations = $AnimatedSprite2D

func _ready():
    $Timer.one_shot = true
    $JumpTimer.one_shot = true
    idle_timer = Timer.new()
    coyote_timer = Timer.new()
    add_child(idle_timer)
    add_child(coyote_timer)
    idle_timer.one_shot = true
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
    
    if Input.is_action_pressed("shift"):
        acceleration = SHIFT_SPEED
        running_text = "very_fast_running"
    else:
        acceleration = SPEED
        running_text = "running"
        
    
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
            is_idle = true
            is_jumping_animation = false
        else:
            is_idle = false
            animations.play(running_text)
            is_jumping_animation = false
            idle_timer_started = false

    IdleAnimations()
    
    
    if direction:
        velocity.x = direction * acceleration
    else:
        velocity.x = move_toward(velocity.x, 0, acceleration)

    move_and_slide()

func IdleAnimations():
 if is_idle and not idle_timer_started:
        animations.play("idle")
        idle_timer.start(IDLE_COOLDOWN)
        idle_timer_started = true
        is_animation_choosed = false
   
 if idle_timer.time_left == 0 and is_idle and not is_animation_choosed:
    is_animation_choosed = true
    if (randi() % 2) :  
      animations.play("idle2")
    else:
      animations.play("idle3")
        
