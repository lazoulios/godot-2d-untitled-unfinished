extends StaticBody2D

@export var slot_data: SlotData

@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready():
	fallfromtree()


func _process(_delta):
	pass

func fallfromtree():
	$AnimationPlayer.play("falling")
	await get_tree().create_timer(5).timeout
	$AnimationPlayer.play("fade")
	await get_tree().create_timer(.3).timeout
	queue_free()


func _on_pickable_body_entered(body:Node2D):
	if body.has_method("player"):
		if body.inventory_data.pick_up_slot_data(slot_data):
			queue_free()
