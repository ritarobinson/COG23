extends KinematicBody2D
class_name Player

#VARIABLES
#calls variables stored in resource
export(Resource) var moveData = preload("res://Player/DefaultPlayerMovementData.tres") as PlayerMovementData

var velocity = Vector2.ZERO
var double_jump = 1
var buffered_jump = false
var coyote_jump = false

onready var jumpBufferTimer: = $JumpBufferTimer
onready var coyoteJumpTimer: = $CoyoteJumpTimer
onready var remoteTransform2D: = $RemoteTransform2D

#FUNCTIONS
func _physics_process(delta):
#	character input
	var input = Vector2.ZERO
#	gets input number depending on key pressed
	input.x = Input.get_axis("ui_left", "ui_right")
	input.y = Input.get_axis("ui_up", "ui_down")

	apply_gravity(delta)
	
#	detects whether character is on floor or not (change in position over time)
	velocity = move_and_slide(velocity, Vector2.UP)
	
#	CHARACTER'S MOVEMENT
	if input.x == 0:
#		character idle animation
		$AnimatedSprite.animation = "idle"
		apply_friction(delta)
	else:
		apply_acceleration(input.x, delta)
#		character running animation
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_h = velocity.x < 0
		$AnimatedSprite.flip_v = false

#	JUMP MOVEMENT
	if is_on_floor():
#		reset double jump
		double_jump = moveData.MaxDoubleJump
	else:
#		character jumping animation
		$AnimatedSprite.animation = "jump"
		$AnimatedSprite.flip_h = velocity.x < 0
		$AnimatedSprite.flip_v = false
	
	if is_on_floor() or coyote_jump:
		input_jump()
	else:
#		jump release
		if Input.is_action_just_released("ui_up") and velocity.y < moveData.ReleaseForce:
			velocity.y = moveData.ReleaseForce
	
#		double jump
		if Input.is_action_just_pressed("ui_up") and double_jump > 0:
			velocity.y = moveData.DoubleJumpForce
			double_jump -= 1
		
#		buffer jump
		if Input.is_action_just_pressed("ui_up"):
			buffered_jump = true
			jumpBufferTimer.start()
	
#		jump falling
		if velocity.y > 5:
			velocity.y += moveData.FallGravity * delta
	
#	used to move character, detect collisions and react appropriately
	var was_on_floor = is_on_floor()
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var just_landed = is_on_floor() and not is_on_floor()
	if just_landed:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.frame = 1
	
#	coyote jump
	var just_left_ground = not is_on_floor() and was_on_floor
	if just_left_ground and velocity.y >= 0:
		coyote_jump = true
		coyoteJumpTimer.start()


#if player dies
func player_die():
#	kills Player
	queue_free()
	Events.emit_signal("player_died")


#connects camera to player
func connect_camera(camera):
	var camera_path = camera.get_path()
	remoteTransform2D.remote_path = camera_path


#jump on imput
func input_jump():
#	can change to is_action_just_pressed() for less immediate jumps
	if Input.is_action_just_pressed("ui_up") or buffered_jump:
		velocity.y = moveData.JumpForce
		buffered_jump = false


#gravity of velocity (change in velosity over time)
func apply_gravity(delta):
	velocity.y += moveData.Gravity * delta
	velocity.y = min(velocity.y, 300)


#friction
func apply_friction(delta):
	velocity.x = move_toward(velocity.x, 0, moveData.Friction * delta) 


#acceleration
func apply_acceleration(amount, delta):
	velocity.x = move_toward(velocity.x, moveData.MaxSpeed * amount, moveData.Acceleration * delta)


#buffer jump timeout
func _on_JumpBufferTimer_timeout():
	buffered_jump = false


#coyote jump timeout
func _on_CoyoteJumpTimer_timeout():
	coyote_jump = false
