extends Node2D
class_name Menu

#initialising variables
export var mainGameScene : PackedScene
export var tutGameScene : PackedScene

func _ready():
#	background solid colour
	VisualServer.set_default_clear_color(Color.mediumturquoise)


#to change to appropriate scene
func _on_NewGameBtn_button_up():
		get_tree().change_scene(mainGameScene.resource_path)


#to change to appropriate scene
func _on_TutorialBtn_button_up():
		get_tree().change_scene(tutGameScene.resource_path)
