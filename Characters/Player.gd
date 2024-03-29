extends CharacterBody2D

@export var inventory_data: InventoryData

@export var move_speed : float = 100
@export var sprint_speed : float = 20
@export var knockback_power = 800

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var input_movement = Vector2.ZERO

enum player_states {WALK, IDLE, RUN, ATTACK, HIT}
var current_state = player_states.WALK

var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true

func _physics_process(_delta):
	enemy_attack()
	match current_state:
		player_states.WALK:
			move()
		player_states.ATTACK:
			attack()
		player_states.IDLE:
			move()
		player_states.RUN:
			move()
		player_states.HIT:
			hit()
	
	if health <=0:
		player_alive = false #go to respawn point
		health = 0
		print("player has been killed")
		self.queue_free()

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
			current_state = player_states.RUN
		else :
			velocity = input_movement * move_speed
			state_machine.travel("walk")
			current_state = player_states.WALK
			

	if input_movement == Vector2.ZERO:
		state_machine.travel("idle")
		velocity = Vector2.ZERO
		current_state = player_states.IDLE

	if Input.is_action_just_pressed("attack"):
		current_state = player_states.ATTACK

	move_and_slide()

func attack():
	state_machine.travel("attack")
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * move_speed
	move_and_slide()

func on_state_reset():
	current_state = player_states.WALK

func _on_player_hitbox_body_exited(body:Node2D):
	if body.has_method("enemy"):
		enemy_in_attack_range = false

func _on_player_hitbox_body_entered(body:Node2D):
	if body.has_method("enemy"):
		enemy_in_attack_range = true

func enemy_attack():
	if enemy_in_attack_range==true and enemy_attack_cooldown==true:
		health -= 10
		knockback()
		current_state = player_states.HIT
		print(health)
		enemy_attack_cooldown = false
		$Timer.start()

func _on_timer_timeout():
	enemy_attack_cooldown = true

func hit():
	state_machine.travel("hit")
	current_state = player_states.WALK

func knockback():
	var knockback_direction = -velocity.normalized() * knockback_power
	velocity = knockback_direction
	move_and_slide()

func player():
	pass
