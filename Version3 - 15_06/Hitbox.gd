extends Area2D

#FUNCTION
func _on_Hitbox_body_entered(body):
#	anytime Hitbox overlaps player,
	if body is Player:
#		die
		body.player_die()

