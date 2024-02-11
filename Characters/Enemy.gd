extends CharacterBody2D

@export var speed : float = 150
var player_chase = false
var player = null

func _ready():
	$AnimatedSprite2D.play("idle")

func _physics_process(_delta):
	if player_chase:
		position += (player.position -position) / speed
		$AnimatedSprite2D.play("walk")
		if (player.position.x - position.x < 0):
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false

func _on_actionable_body_shape_entered(_body_rid:RID, body:Node2D, _body_shape_index:int, _local_shape_index:int):
	player = body
	player_chase = true
	

func _on_actionable_body_shape_exited(_body_rid:RID, _body:Node2D, _body_shape_index:int, _local_shape_index:int):
	player = null
	player_chase = false
	$AnimatedSprite2D.play("idle")
