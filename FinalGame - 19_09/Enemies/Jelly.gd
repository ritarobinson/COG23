extends Node2D
class_name Jelly

#classifies enemy states
enum { HOVER, FALL, LAND, RISE }

#initialises variables
var state = HOVER

onready var start_position = global_position
onready var timer = $Timer
onready var raycast = $RayCast2D
onready var collision = $Hitbox/CollisionShape2D

#Functions
func _physics_process(delta):
	match state:
		HOVER: hover_state()
		FALL: fall_state(delta)
		LAND: land_state()
		RISE: rise_state(delta)


#when enemy state is hover,
func hover_state():
	state = FALL


#when enemy state is fall, and detects landing
func fall_state(delta):
	position.y += 85 * delta
	$AnimatedSprite.flip_v = true
	if raycast.is_colliding():
		var collision_point = raycast.get_collision_point()
		position.y = collision_point.y
		state = LAND
		timer.start(1.0)


#when enemy state is land,
func land_state():
	if timer.time_left == 0:
		state = RISE


#when enemy state is rising,
func rise_state(delta):
	$AnimatedSprite.flip_v = false
	position.y = move_toward(position.y, start_position.y, 25 * delta)
	if position.y == start_position.y: 
		state = HOVER
