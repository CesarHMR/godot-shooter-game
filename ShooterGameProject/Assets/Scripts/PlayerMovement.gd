extends KinematicBody2D

var velocity = Vector2.ZERO
var movementSpeed = 100
var gravity = 1200
var jumpForce = -370

func _physics_process(delta):
	_process_player_gravity(delta)
	_process_player_movement()
	_process_player_jump()
	move_and_slide(velocity)

func _process_player_movement():
	var moveDirection = int(Input.is_action_pressed("move_right")) - int (Input.is_action_pressed("move_left"))
	velocity.x = movementSpeed * moveDirection
	
	if moveDirection != 0:
		$Sprite.scale.x = moveDirection

func _process_player_gravity(delta):
	velocity.y += gravity * delta
	
func _process_player_jump():
	if Input.is_action_just_pressed("jump"):
		velocity.y = 0
		velocity.y += jumpForce
