extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var inventory_interface: Control = $UI/InventoryInterface

func _ready():
	inventory_interface.set_player_inventory_data(player.inventory_data)


func _process(_delta):
	pass



func _on_to_new_ville_body_entered(body:Node2D):
	if body.has_method("player"):
		SceneManager.change_scene(SceneManager.new_ville, 490, 890,player.inventory_data)

