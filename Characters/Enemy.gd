extends CharacterBody2D

const gold = preload("res://Objects/gold.tscn")

@export var _permanenceValue : String 
@export var speed : float = 150
@export var health = 100
@onready var anim_player = $AnimationPlayer

var player_chase = false
var player = null


var move = false

func _ready():
	anim_player.play("idle")
	if SceneManager._enemyPermanence.has(_permanenceValue):
		self.queue_free()	
	else:
		pass

func _physics_process(_delta):
	if health <=0:
		anim_player.play("death")
		SceneManager._enemyPermanence.append(_permanenceValue)
	elif player_chase:
		if move == true:
			position += (player.position -position) / speed
			anim_player.play("walk")
			move_and_collide(Vector2(0,0))

func _on_actionable_body_shape_entered(_body_rid:RID, body:Node2D, _body_shape_index:int, _local_shape_index:int):
	player = body
	player_chase = true
	anim_player.play("walk")
	move = true
	
func _on_actionable_body_shape_exited(_body_rid:RID, _body:Node2D, _body_shape_index:int, _local_shape_index:int):
	player = null
	player_chase = false
	anim_player.play("idle")

func enemy():
	pass

func _on_enemy_hitbox_area_entered(area):
	if area.name== "Sword":
		move = false
		$AnimationPlayer.play("hit")
		health -= 20

func _on_enemy_hitbox_area_exited(_area):
	pass # Replace with function body.

func move_char():
	move = true

#used to not allow player to move from lvl till killing the mobs
func add_to_kills_needed():
	SceneManager.kills_to_change_lvl += 1

func draw_loot():
	var gold_instance = gold.instantiate()
	gold_instance.global_position = $Marker2D.global_position
	get_parent().add_child(gold_instance)

