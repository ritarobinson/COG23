extends Node2D


func _ready():
#	background solid colour
	VisualServer.set_default_clear_color(Color.cadetblue)


func _on_GoBtn_button_up():
	get_tree().change_scene("res://Menus/Menu.tscn")
