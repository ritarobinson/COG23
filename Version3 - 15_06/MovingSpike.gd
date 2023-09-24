tool
extends Path2D

enum ANIMATION_TYPE{
	LOOP,
	BOUNCE
}

export(ANIMATION_TYPE) var animation_type
export(float) var speed = 1.0 setget set_speed

onready var animationPlayer: = $AnimationPlayer

func set_animation_type(value):
	animation_type = value
	var aP = find_node("AnimationPlayer")
	if aP: play_updated_animation(aP)

func set_speed(value):
	speed = value
	var aP = find_node("AnimationPlayer")
	if aP: aP.playback_speed = speed

func _ready():
	play_updated_animation(animationPlayer)

func play_updated_animation(aP):
	match animation_type:
		ANIMATION_TYPE.LOOP: aP.play("MoveAlongPathLoop")
		ANIMATION_TYPE.BOUNCE: aP.play("MoveAlongPathBounce")
