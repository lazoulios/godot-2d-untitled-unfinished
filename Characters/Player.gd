extends CharacterBody2D

@export var move_speed : float = 100
@export var sprint_speed : float = 20
@export var starting_direction : Vector2 = Vector2(0,1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

func _ready():
	update_animation_parameters(starting_direction)

func _physics_process(_delta):
	# Get input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

	var sprint = Input.get_action_strength("run")
	var attack = Input.get_action_strength("attack")

	update_animation_parameters(input_direction)

	# Update velocity
	if sprint == 1:
		velocity = input_direction.normalized() * (move_speed + sprint_speed)
	else:
		velocity = input_direction.normalized() * move_speed

	# Move and Slide func ises velocity of character body to move character on map
	move_and_slide()

	pick_new_state(attack, sprint)

func update_animation_parameters(move_input : Vector2):
	# Don't change animation parameters if there is no move input
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/idle/blend_position",move_input)
		animation_tree.set("parameters/walk/blend_position",move_input)
		animation_tree.set("parameters/run/blend_position",move_input)
		animation_tree.set("parameters/attack/blend_position",move_input)
		
func pick_new_state(attack, sprint):
	if (attack==1):
		state_machine.travel("attack")
	elif (velocity!=Vector2.ZERO && sprint!=1):
		state_machine.travel("walk")
	elif (velocity!=Vector2.ZERO && sprint==1):
		state_machine.travel("run")
	else:
		state_machine.travel("idle")