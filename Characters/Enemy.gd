extends CharacterBody2D

@export var speed : float = 50
var player_chase = false
var player = null

func _physics_process(delta):
	if player_chase:
		position += (player.position -position) / speed


func _on_actionable_body_entered(body:Node2D):
	player = body
	player_chase = true


func _on_actionable_body_exited(body:Node2D):
	player = null
	player_chase = false
