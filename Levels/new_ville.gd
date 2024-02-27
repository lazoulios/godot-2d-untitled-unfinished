extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var inventory_interface: Control = $UI/InventoryInterface

func _ready():
	inventory_interface.set_player_inventory_data(player.inventory_data)

func _process(_delta):
	pass


func _on_to_route_1_body_entered(body:Node2D):
	if body.has_method("player"):
		SceneManager.change_scene(SceneManager.route_1,408, -1364,player.inventory_data)
