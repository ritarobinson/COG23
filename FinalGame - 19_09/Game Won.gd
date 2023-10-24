extends Control


func _ready():
#	background solid colour
	VisualServer.set_default_clear_color(Color.mediumturquoise)


func _on_ContinueBtn_button_up():
	get_tree().change_scene("res://Menus/Menu.tscn")
