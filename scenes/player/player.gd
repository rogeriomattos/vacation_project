extends CharacterBody2D


const SPEED = 400.0
const JUMP_VELOCITY = -600.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func handleAnimationDirection(direction:float) -> void:
	if direction < 0:
		animated_sprite.flip_h = true
	elif direction > 0:
		animated_sprite.flip_h = false
	 
func handleMovimentation(direction:float) -> void:
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor(): 
			animated_sprite.play('walk')
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor(): 
			animated_sprite.play('idle')
	move_and_slide()

func handleGravity(delta: float) -> void: 
	# Add the gravity.
	if not is_on_floor():
		animated_sprite.play('jump')
		velocity += get_gravity() * delta

func handleJump() -> void:
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		animated_sprite.play('jump')
		velocity.y = JUMP_VELOCITY

func _physics_process(delta: float) -> void:
	handleGravity(delta);
	handleJump();
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	handleAnimationDirection(direction)
	handleMovimentation(direction);
	
