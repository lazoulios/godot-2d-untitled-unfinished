extends CharacterBody2D

@export var speed : float = 100

var player_chase = false
var player = null

func _physics_process(_delta):
	if player_chase:
		position = position + (player.position -position) / speed


func _on_detection_area_body_entered(body:Node2D):
	player = body
	player_chase = true


func _on_detection_area_body_exited(_body:Node2D):
	player = null
	player_chase = false 
