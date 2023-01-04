extends KinematicBody2D

var velocity = Vector2.ZERO
var movementSpeed = 100
var gravity = 1200
var jump_force = -370
onready var raycasts = $Raycasts
onready var animation_player = $AnimationPlayer

func _process(delta):
	_process_player_animation()
	_process_player_gravity(delta)
	_process_player_movement()
	move_and_slide(velocity)

func _physics_process(delta):
	pass

func _process_player_movement():
	var moveDirection = int(Input.is_action_pressed("move_right")) - int (Input.is_action_pressed("move_left"))
	#velocity.x = lerp(velocity.x, movementSpeed * moveDirection, 0.2)
	velocity.x = movementSpeed * moveDirection
	
	if moveDirection != 0:
		$Sprite.scale.x = moveDirection

func _process_player_gravity(delta):		
	if velocity.y < 300:
		velocity.y += gravity * delta


func _input(event: InputEvent) -> void :
	if event.is_action_pressed("jump") and _is_grounded():
		_jump()

func _jump():
	print("jump")
	velocity.y = jump_force

func _is_grounded():
	for raycast in raycasts.get_children():
		if raycast.is_colliding():
			return true
	
	return false
	
func _process_player_animation():
	var anim = "Player_Idle"
	
	if int(Input.is_action_pressed("move_right")) - int (Input.is_action_pressed("move_left")) != 0:
		anim = "Player_Run"
		
	if !_is_grounded():
		anim = "Player_Jump"
	
	if animation_player.assigned_animation != anim:
		animation_player.play(anim)
