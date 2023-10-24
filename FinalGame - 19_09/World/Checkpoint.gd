extends Area2D

#initialising variable
var active = true

#if player hits checkpoint,
func _on_Checkpoint_body_entered(body):
	if not body is Player: return
	if not active: return
	active = false
	$CheckpointReach.visible = true
	Events.emit_signal("hit_checkpoint", position)
