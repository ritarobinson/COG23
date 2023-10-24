extends Control
class_name Difficulty

#initialising variables
export var easy : PackedScene
export var hard : PackedScene

onready var Value = $CenterContainer/Slider/HSlider.value

func _ready():
#	background solid colour
	VisualServer.set_default_clear_color(Color.mediumturquoise)


#once button is pressed
func _on_GoBtn_button_up():
	if typeof(Value) == TYPE_REAL:
		if Value == 0:
			get_tree().change_scene(easy.resource_path)
		elif Value == 10:
			get_tree().change_scene(hard.resource_path)
		elif Value != 0 and Value != 10:
			$Error.visible == true


#if slider value changes
func _on_HSlider_value_changed(value):
	var changedValue = value
	Value = changedValue
