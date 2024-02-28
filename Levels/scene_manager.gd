extends CanvasLayer

#for spawning enemies
var _enemyPermanence = []
var _loot_collected = []

const main = preload("res://Levels/main.tscn")
const route_1 = preload("res://Levels/route_1.tscn")
const new_ville = preload("res://Levels/new_ville.tscn")
const route_2 = preload("res://Levels/route_2.tscn")

var kills_to_change_lvl = 0

func _ready():
	get_node("ColorRect").hide()
	var _ignore = _enemyPermanence + _loot_collected

func change_scene(scene_path, x, y, inventory):
	get_node("ColorRect").show()
	get_node("AnimationPlayer").play("trans_in")
	await get_node("AnimationPlayer").animation_finished

	var scene = scene_path.instantiate() #loading new scene
	scene.get_node("Player").inventory_data = inventory
	scene.get_node("UI").hide()
	get_tree().get_root().get_child(1).free() #deleting old scene
	get_tree().get_root().add_child(scene) #adding new scene
	scene.get_node("Player").position = Vector2(x ,y)
	
	
	get_node("AnimationPlayer").play("trans_out")
	await get_node("AnimationPlayer").animation_finished
	get_node("ColorRect").hide()
	scene.get_node("UI").show()
