extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_to_main_body_entered(body:Node2D):
	if body.has_method("player"):
		SceneManager.change_scene(SceneManager.main, 448, 160)



func _on_to_new_ville_body_entered(body:Node2D):
	if body.has_method("player"):
		SceneManager.change_scene(SceneManager.new_ville, 787, 1081)
