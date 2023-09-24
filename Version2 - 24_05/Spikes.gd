extends Area2D


func _on_Spikes_body_entered(body):
	#	kills and respawns Player
	if body is Player:
		body.queue_free()
