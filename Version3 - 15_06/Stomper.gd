extends Node2D

enum {HOVER, FALL, LAND, RISE}

var state = HOVER

onready var start_position = global_position
onready var timer = $Timer
onready var raycast = $RayCast2D


func _physics_process(delta):
	match state:
		HOVER: hover_state()
		FALL: fall_state(delta)
		LAND: land_state()
		RISE: rise_state(delta)

func hover_state():
	state = FALL
	$AnimatedSprite.play("rising")

func fall_state(delta):
	position.y += 85 * delta
	$AnimatedSprite.play("falling")
	if raycast.is_colliding():
		var collision_point = raycast.get_collision_point()
		position.y = collision_point.y
		state = LAND
		timer.start(1.0)

func land_state():
	if timer.time_left == 0:
		state = RISE

func rise_state(delta):
	$AnimatedSprite.play("rising")
	position.y = move_toward(position.y, start_position.y, 25 * delta)
	if position.y == start_position.y: 
		state = HOVER
