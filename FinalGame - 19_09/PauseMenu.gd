extends Control

#initialising variables
var is_paused = false setget set_is_paused

#if player preses esc(pause assigned button),
func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused


#pauses scene
func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused


#resumes game is player clicks resume button
func _on_ResumeBtn_button_up():
	self.is_paused = false


#reloads scene/resets if player clicks restart button
func _on_RestartBtn_button_up():
	self.is_paused = false
	get_tree().reload_current_scene()


#closes window if player clicks quit button
func _on_QuitBtn_button_up():
		get_tree().quit()

