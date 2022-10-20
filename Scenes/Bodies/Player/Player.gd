extends KinematicBody2D

const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500

var velocity = Vector2.ZERO

#delta contains time the last frame took to process. Delta = 1/60 if 60FPS, for example.
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	#This accounts for Analogue Stick "tilt" strength.
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	#This prevents diagnal movement from being faster than horizontal/vertical movement.
	input_vector = input_vector.normalized()
	#Handles the speed/acceleration of the player.
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	velocity = move_and_slide(velocity)
