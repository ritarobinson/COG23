tool
extends Path2D
class_name BigJelly

#classifies animation type
enum ANIMATION_TYPE{ LOOP, BOUNCE }

#initialising variables
export(ANIMATION_TYPE) var animation_type
export(float) var speed = 1.0 setget set_speed

onready var animationPlayer: = $AnimationPlayer

#starts animation when scene initialised
func _ready():
	play_updated_animation(animationPlayer)


#sets the animation type of enemy
func set_animation_type(value):
	animation_type = value
	var aP = find_node("AnimationPlayer")
	if aP: play_updated_animation(aP)


#sets the speed of enemy
func set_speed(value):
	speed = value
	var aP = find_node("AnimationPlayer")
	if aP: aP.playback_speed = speed


#plays the appropriate animation
func play_updated_animation(aP):
	match animation_type:
		ANIMATION_TYPE.LOOP: aP.play("MoveAlongPathLoop")
		ANIMATION_TYPE.BOUNCE: aP.play("MoveAlongPathBounce")
