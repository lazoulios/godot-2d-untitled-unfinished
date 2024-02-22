extends Node2D

var k

@onready var player: CharacterBody2D = $Player
@onready var inventory_interface: Control = $UI/InventoryInterface

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory_interface.set_player_inventory_data(player.inventory_data)
	k = get_node("Enemies/Enemy")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_next_area_body_entered(body:Node2D):
	if k:
		if SceneManager.kills_to_change_lvl < 1:
			print("Kill all to change scene")
		else:
			if body.has_method("player"):
				SceneManager.change_scene(SceneManager.route_1, 400, 900)
	else:
		SceneManager.kills_to_change_lvl=1
