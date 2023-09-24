extends KinematicBody2D

#VARIABLES
var direction = Vector2.RIGHT
var velocity = Vector2.ZERO
#variables ready when scene loaded
onready var edgeCheckRight: = $EdgeCheckRight
onready var edgeCheckLeft: = $EdgeCheckLeft
onready var sprite: = $AnimatedSprite

#FUNCTIONS
#_physics_process == frame rate sync to physics
func _physics_process(_delta):
#	checks for wall
	var found_wall = is_on_wall()
#	checks for edge
	var found_edge = not edgeCheckRight.is_colliding() or not edgeCheckLeft.is_colliding()
	
#	command for if wall or edge found
	if found_wall or found_edge:
		direction.x *= -1
	
#	flip character skin for change in movement direction
	sprite.flip_h = direction.x > 0
	
#	character movement
	velocity = direction * 25
	var _move_error = move_and_slide(velocity, Vector2.UP)
	
