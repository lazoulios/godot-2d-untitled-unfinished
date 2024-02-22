extends Node2D

@export var _loot_collected_value : String 

const potion = preload("res://Objects/potion.tscn")

var state = "apples"
var player_in_area = false

func _ready():
	if SceneManager._loot_collected.has(_loot_collected_value):
		state = "no apples"
	else:
		state = "apples"

func _process(_delta):

	if state == "no apples":
		$AnimatedSprite2D.play("no_apples")
	if state == "apples":
		$AnimatedSprite2D.play("apples")
		if player_in_area == true:
			if Input.is_action_just_pressed("e"):
				draw_potion()
				state = "no apples"
				SceneManager._loot_collected.append(_loot_collected_value)


func _on_pickable_area_body_exited(body:Node2D):
	if body.has_method("player"):
		player_in_area = false

func _on_pickable_area_body_entered(body:Node2D):
	if body.has_method("player"):
		player_in_area = true

func draw_potion():
	var potion_instance = potion.instantiate()
	potion_instance.global_position = $Marker2D.global_position
	get_parent().add_child(potion_instance)

	await get_tree().create_timer(3).timeout
