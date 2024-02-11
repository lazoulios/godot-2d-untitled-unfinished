extends CharacterBody2D

@export var move_speed : float = 100
@export var sprint_speed : float = 20

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var input_movement = Vector2.ZERO

enum player_states {MOVE, IDLE, RUN, ATTACK}
var current_state = player_states.MOVE

func _physics_process(_delta):
	match current_state:
		player_states.MOVE:
			move()
		player_states.ATTACK:
			attack()

func move():
	input_movement = Input.get_vector("left","right","up","down")
	if input_movement != Vector2.ZERO:
		animation_tree.set("parameters/idle/blend_position",input_movement)
		animation_tree.set("parameters/walk/blend_position",input_movement)
		animation_tree.set("parameters/run/blend_position",input_movement)
		animation_tree.set("parameters/attack/blend_position",input_movement)
		if Input.get_action_strength("run"):
			velocity = input_movement * (move_speed+sprint_speed)
			state_machine.travel("run")
		else :
			velocity = input_movement * move_speed
			state_machine.travel("walk")
			

	if input_movement == Vector2.ZERO:
		state_machine.travel("idle")
		velocity = Vector2.ZERO

	if Input.is_action_just_pressed("attack"):
		current_state = player_states.ATTACK

	move_and_slide()

func attack():
	state_machine.travel("attack")
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * move_speed
	move_and_slide()

func on_state_reset():
	current_state = player_states.MOVE
