extends Node2D

const PlayerScene = preload("res://Player.tscn")

var player_spawn_location = Vector2.ZERO

onready var camera: = $Camera2D
onready var player: = $Player
onready var timer: = $Timer

#FUNCTION
#_ready == when node has entered scene tree
func _ready():
#	backfround solid colour
	VisualServer.set_default_clear_color(Color.cadetblue)
	player.connect_camera(camera)
	player_spawn_location = player.global_position
#	object containing singal. connect signal, object connecting to, function called
	Events.connect("player_died", self, "_on_player_died")
	Events.connect("hit_checkpoint", self, "_on_hit_checkpoint")
	
func _on_player_died():
	timer.start(1.0)
	yield(timer, "timeout")
	var player = PlayerScene.instance()
	add_child(player)
	player.global_position = player_spawn_location
	player.connect_camera(camera)

func _on_hit_checkpoint(checkpoint_position):
	player_spawn_location = checkpoint_position
