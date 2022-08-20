extends Node2D

var player_mob = load("res://Scenes/Mob_player.tscn")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		var player = player_mob.instance()
		add_child(player)
