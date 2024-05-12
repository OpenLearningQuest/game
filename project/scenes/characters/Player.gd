extends CharacterBody2D

# how fast the player should move in pixels per second
@export var player_speed = 100

var speed_vector = Vector2(player_speed, player_speed)
var move_to = null

func _input(event):
	if event.is_action_pressed("player_move"):
		move_to = get_viewport().get_mouse_position()

func _change_player_direction(new_velocity):
	if new_velocity.x > new_velocity.y and new_velocity.x < - new_velocity.y:
		$PlayerAnimation.play("MoveUp")
	elif new_velocity.x < new_velocity.y and new_velocity.x > - new_velocity.y:
		$PlayerAnimation.play("MoveDown")
	else:
		$PlayerAnimation.play("MoveSide")
		$PlayerSprite.flip_h = new_velocity.x > 0

func _physics_process(_delta):
	# only calculate move vector if player should move
	if move_to:
		var move_vector = move_to - global_position
		var player_arrived_at_destination = move_vector.length() < 3
		
		if player_arrived_at_destination:
			# player should no longer move
			move_to = null
			
			# Stop moving by setting velocity to zero
			velocity = Vector2.ZERO
		else:
			# player should move
			# normalize move vector to range 0:1
			velocity = move_vector.normalized() * speed_vector
			move_and_slide()
		
			_change_player_direction(velocity)
