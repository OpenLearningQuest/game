extends KinematicBody2D

var speed = Vector2(64, 64) # 64 pixels per second
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
	if move_to:
		var move_vector = move_to - global_position
		
		if move_vector.length() > 3:
			var velocity = move_and_slide(move_vector.normalized() * speed)
			
			_change_player_direction(velocity)
