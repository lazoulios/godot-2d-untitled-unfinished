extends CharacterBody2D

@export var speed : float = 150
var player_chase = false
var player = null

var health = 100

func _ready():
	$AnimationPlayer.play("idle")

func _physics_process(_delta):
	if health <=0:
		$AnimationPlayer.play("death")
		await $AnimationPlayer.animation_finished
		queue_free()
	if player_chase:
		position += (player.position -position) / speed
		$AnimationPlayer.play("walk")

func _on_actionable_body_shape_entered(_body_rid:RID, body:Node2D, _body_shape_index:int, _local_shape_index:int):
	player = body
	player_chase = true
	
func _on_actionable_body_shape_exited(_body_rid:RID, _body:Node2D, _body_shape_index:int, _local_shape_index:int):
	player = null
	player_chase = false
	$AnimationPlayer.play("idle")

func enemy():
	pass


func _on_enemy_hitbox_area_entered(area):
	if area.name== "Sword":
		health -= 20
		print("Slime health: ",health)
		


func _on_enemy_hitbox_area_exited(_area):
	pass # Replace with function body.

