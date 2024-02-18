extends CanvasLayer

const main = preload("res://Levels/main.tscn")
const route_1 = preload("res://Levels/route_1.tscn")

func _ready():
	get_node("ColorRect").hide()

func change_scene(scene_path):
	get_node("ColorRect").show()
	get_node("AnimationPlayer").play("trans_in")
	await get_node("AnimationPlayer").animation_finished

	var scene = scene_path.instantiate() #loading new scene
	get_tree().get_root().get_child(1).free() #deleting old scene
	get_tree().get_root().add_child(scene) #adding new scene
	
	
	get_node("AnimationPlayer").play("trans_out")
	await get_node("AnimationPlayer").animation_finished
	get_node("ColorRect").hide()
