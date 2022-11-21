extends KinematicBody2D

export var player_speed = 100
var speed_vector = Vector2(player_speed, player_speed) # 64 pixels per second
var move_to = null

func _input(event):
	if event.is_action_pressed("player_move"):
		move_to = get_viewport().get_mouse_position()

func _change_player_direction(velocity):
	if velocity.x > velocity.y && velocity.x < -velocity.y:
		$PlayerAnimation.play("MoveUp")
	elif velocity.x < velocity.y && velocity.x > -velocity.y:
		$PlayerAnimation.play("MoveDown")
	else:
		$PlayerAnimation.play("MoveSide")
		
		$PlayerSprite.flip_h = velocity.x < 0

func _physics_process(delta):
	# only calculate move vector if player should move
	if move_to:
		var move_vector = move_to - global_position
		
		var player_arrived_at_destination = move_vector.length() < 3
		
		if player_arrived_at_destination:
			# player should no longer move
			move_to = null
			
			pass
		else:
			# player should move
			# normalize move vector to range 0:1
			var velocity = move_and_slide(
				move_vector.normalized() * speed_vector
			)
		
			_change_player_direction(velocity)
