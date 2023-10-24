extends Node2D

#initialising variables
const PlayerScene = preload("res://Player/Player.tscn")
const MaxHealth = 3

var player_spawn_location = Vector2.ZERO
var health = MaxHealth

onready var camera: = $Camera2D
onready var player: = $Player
onready var timer: = $Timer
onready var player_health: = $Camera2D/MenuButtons/Health

onready var jelly: = $Camera2D/MenuButtons/JellyCunter/CollectJelly
onready var jelly2: = $Camera2D/MenuButtons/JellyCunter/CollectJelly2
onready var jelly3: = $Camera2D/MenuButtons/JellyCunter/CollectJelly3
onready var smll_jelly: = $Camera2D/MenuButtons/SmallJellyCounter/CollectSmllJ
onready var smll_jelly2: = $Camera2D/MenuButtons/SmallJellyCounter/CollectSmllJ2
onready var smll_jelly3: = $Camera2D/MenuButtons/SmallJellyCounter/CollectSmllJ3
onready var smll_jelly4: = $Camera2D/MenuButtons/SmallJellyCounter/CollectSmllJ4
onready var big_jelly: = $Camera2D/MenuButtons/HARDBigJellyCounter/CollectBJ
onready var big_jelly2: = $Camera2D/MenuButtons/HARDBigJellyCounter/CollectBJ2

#FUNCTIONS
#_ready == when node has entered scene tree
func _ready():
#	backfround solid colour
	VisualServer.set_default_clear_color(Color.mediumturquoise)
#	initialises health label
	set_health_label()
#	connecting and setting when initial scene tree
	player.connect_camera(camera)
	player_spawn_location = player.global_position
#	connecting signals
	Events.connect("player_died", self, "_on_player_died")
	Events.connect("hit_checkpoint", self, "_on_hit_checkpoint")
	Events.connect("player_damage", self, "_on_player_damage")
	Events.connect("collect", self, "_on_collect")


#once player dies, respawns or kills player
func _on_player_died():
	timer.start(0.5)
	yield(timer, "timeout")
	var player = PlayerScene.instance()
	if health != 0:
#		respawns Player
		add_child(player)
		player.global_position = player_spawn_location
		player.connect_camera(camera)
	elif health == 0:
		get_tree().change_scene("res://Game Over.tscn")


#setting player position if checkpoint hit
func _on_hit_checkpoint(checkpoint_position):
	player_spawn_location = checkpoint_position


#if player collides with an object
func _on_player_damage(body):
	if body is Player:
#		damage to player
		health -= 1
		body.player_die()
		set_health_label()
		if health == 0:
#			die
			body.player_die()


#'collects' jellyfish, user visual
func _on_collect(collider_val):
	if collider_val == "Reg" and jelly.visible == false:
		jelly.visible = true
	elif collider_val == "Reg" and jelly.visible == true and jelly2.visible == false:
		jelly2.visible = true
	elif collider_val == "Reg" and jelly2.visible == true and jelly3.visible == false:
		jelly3.visible = true
	
	elif collider_val == "Sml" and smll_jelly.visible == false:
		smll_jelly.visible = true
	elif collider_val == "Sml" and smll_jelly.visible == true and smll_jelly2.visible == false:
		smll_jelly2.visible = true
	elif collider_val == "Sml" and smll_jelly2.visible == true and smll_jelly3.visible == false:
		smll_jelly3.visible = true
	elif collider_val == "Sml" and smll_jelly3.visible == true and smll_jelly4.visible == false:
		smll_jelly4.visible = true
	
	elif collider_val == "Big" and big_jelly.visible == false:
		big_jelly.visible = true
	elif collider_val == "Big" and big_jelly.visible == true and big_jelly2.visible == false:
		big_jelly2.visible = true
	else: pass
	
#	if all jellyfish are collected
	if jelly.visible == true and jelly2.visible == true and jelly3.visible == true and smll_jelly.visible == true and smll_jelly2.visible == true and smll_jelly3.visible == true and smll_jelly4.visible == true and big_jelly.visible == true and big_jelly2.visible == true:
		get_tree().change_scene("res://Game Won.tscn")


#health label visual - for user 
func set_health_label():
	player_health.text = "Health: %s" % health
