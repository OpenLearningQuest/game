extends CharacterBody3D


const SPEED = 10
const JUMP_VELOCITY = 4

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
	if Input.is_action_just_released("move_left"):
		$AnimatedSprite3D.flip_h = false
		
		
	if Input.is_action_pressed("move_left"):
		$AnimatedSprite3D.flip_h = true
		$AnimatedSprite3D.play("walk_left")
		
		
	elif Input.is_action_pressed("move_right"):
		$AnimatedSprite3D.play("walk_right")
		
	elif Input.is_action_pressed("move_up"):
		$AnimatedSprite3D.play("walk_down")
		
	elif Input.is_action_pressed("move_down"):
		$AnimatedSprite3D.play("walk_down")
	else:
		$AnimatedSprite3D.play("idle")
		
