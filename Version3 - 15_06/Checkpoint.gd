extends Area2D

var active = true

func _on_Checkpoint_body_entered(body):
	if not body is Player: return
	if not active: return
	$AnimatedSprite.play("checked")
	active = false
	Events.emit_signal("hit_checkpoint", position)
