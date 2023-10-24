extends Area2D
class_name Hitbox

#initialiaing variables
var enter = false

func _ready():
	enter = false


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		enter = true
	if event.is_action_released("ui_accept"):
		enter = false


#detects overlaps, emits a signal to trigger player damage or collect
func _on_Hitbox_body_entered(body):
#	anytime Hitbox overlaps,
	var collider = self.name
	
	var object = collider.split("b", true, 1)
	var collider_val = object[0]
	
	if len(collider_val) == 3 and collider_val == "Hit":
		Events.emit_signal("player_damage", body)
	
	elif collider_val != "Hit" and enter == true:
		self.owner.queue_free()
		Events.emit_signal("collect", collider_val)

