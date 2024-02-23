extends Node2D

var k
@onready var player: CharacterBody2D = $Player
@onready var inventory_interface: Control = $UI/InventoryInterface

func _ready():
	inventory_interface.set_player_inventory_data(player.inventory_data)
	k = get_node("Enemies/Enemy")

func _process(_delta):
	pass

func _on_next_area_body_entered(body:Node2D):
	if body.has_method("player"):
		if k:
			if SceneManager.kills_to_change_lvl < 1:
				print("Kill all to change scene")
			else:
				if body.has_method("player"):
					get_node("UI").hide()
					SceneManager.change_scene(SceneManager.route_1, 400, 900, player.inventory_data)
		else:
			SceneManager.kills_to_change_lvl=1
