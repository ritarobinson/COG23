extends KinematicBody2D

#VARIABLES
export var JumpForce = -85
export var ReleaseForce = -35
export var MaxSpeed = 50
export var Acceleration = 10
export var Friction = 10
export var Gravity = 4
export var FallGravity = 2
var velocity = Vector2.ZERO

#FUNCTIONS

#every single physics frame in game, default 60 FPS(delta{is the elapsed time since previous frame.} = 1/60 per sec)
func _physics_process(_delta):
	
	apply_gravity()
	
	#detects whether character is on floor or not
	velocity = move_and_slide(velocity, Vector2.UP)
	
	#character input
	var input = Vector2.ZERO
	#gets input number depending on key pressed
	input.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	#character's movement
	if input.x == 0:
		#character idle animation
		$AnimatedSprite.animation = "idle"
		apply_friction()
	else:
		apply_acceleration(input.x)
		#character running animation
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_h = velocity.x > 0
		$AnimatedSprite.flip_v = false
		
	#jump movement
	if is_on_floor():
		#can change to is_action_just pressed() for less immediate jumps
		if Input.is_action_pressed("ui_up"):
			velocity.y = JumpForce
	else:
		#character jumping animation
		$AnimatedSprite.animation = "jump"
		$AnimatedSprite.flip_h = velocity.x > 0
		$AnimatedSprite.flip_v = false
		if Input.is_action_just_released("ui_up") and velocity.y < ReleaseForce:
			velocity.y = ReleaseForce
	
		#jump falling
		if velocity.y > 5:
			velocity.y += FallGravity
	
	#used to move character, detect collisions and react appropriately
	velocity = move_and_slide(velocity)
	var just_landed = is_on_floor() and not is_on_floor()
	if just_landed:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.frame = 1

#gravity of velocity
func apply_gravity():
	velocity.y += Gravity
	velocity.y = min(velocity.y, 300)

#friction
func apply_friction():
	velocity.x = move_toward(velocity.x, 0, Friction)

#acceleration
func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, MaxSpeed * amount, Acceleration)


